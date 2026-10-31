pipeline {
    agent { label 'ubuntu-docker' }

    parameters {
        booleanParam(name: 'DEPLOY_EC2_PREVIEW', defaultValue: false,
            description: 'Deploy preview to EC2 after CI passes; requires a working database configured on EC2.')
        string(name: 'EC2_HOST', defaultValue: '16.178.41.15',
            description: 'Current EC2 public IPv4; verify its host key on the agent first.')
    }

    options {
        disableConcurrentBuilds()
        timeout(time: 20, unit: 'MINUTES')
        // Declarative Pipeline normally checks out automatically in SCM mode.
        skipDefaultCheckout(true)
    }

    stages {
        stage('Checkout GenZ Fashion') {
            steps {
                checkout scm
            }
        }

        stage('Frontend test and build') {
            steps {
                sh '''
                    set -eu

                    docker run --rm \
                        --user "$(id -u):$(id -g)" \
                        -e HOME=/tmp \
                        -e npm_config_cache=/tmp/npm-cache \
                        --mount "type=bind,source=$WORKSPACE,target=/workspace" \
                        --workdir /workspace/GenZFashion.Web \
                        node:24-bookworm-slim \
                        sh -c '
                            set -eu
                            node --version
                            npm --version
                            npm ci
                            npm test
                            npm run format:check
                            npm run build
                        '
                '''
            }
        }

        stage('Backend build and publish') {
            steps {
                sh '''
                    set -eu

                    docker run --rm \
                        --user "$(id -u):$(id -g)" \
                        -e HOME=/tmp \
                        -e DOTNET_CLI_HOME=/tmp/dotnet-home \
                        -e NUGET_PACKAGES=/tmp/nuget/packages \
                        -e DOTNET_NOLOGO=true \
                        --mount "type=bind,source=$WORKSPACE,target=/workspace" \
                        --workdir /workspace \
                        mcr.microsoft.com/dotnet/sdk:10.0 \
                        sh -c '
                            set -eu
                            dotnet --version

                            dotnet restore \
                                GenZFashion.Api/GenZFashion.Api.csproj

                            dotnet build \
                                GenZFashion.Api/GenZFashion.Api.csproj \
                                --configuration Release \
                                --no-restore

                            dotnet publish \
                                GenZFashion.Api/GenZFashion.Api.csproj \
                                --configuration Release \
                                --no-build \
                                --no-restore \
                                --output /tmp/genzfashion-publish

                            test -f /tmp/genzfashion-publish/GenZFashion.Api.dll
                            echo "PASS: backend build and publish completed."
                        '
                '''
            }
        }
        stage('Build application images') {
            steps {
                sh '''
                    set -eu
                    tag="$(git rev-parse --short=12 HEAD)"

                    docker build \
                        --file GenZFashion.Api/Dockerfile \
                        --tag "genzfashion-api:$tag" \
                        .

                    docker build \
                        --file GenZFashion.Web/Dockerfile \
                        --tag "genzfashion-web:$tag" \
                        .

                    docker image inspect \
                        --format '{{.RepoTags}} size={{.Size}} bytes' \
                        "genzfashion-api:$tag" "genzfashion-web:$tag"

                    docker run --rm --network none \
                        --entrypoint nginx "genzfashion-web:$tag" -t

                    docker run --rm --network none \
                        --entrypoint sh "genzfashion-api:$tag" -c '
                            set -eu
                            test "$(id -u)" -ne 0
                            test -f /app/GenZFashion.Api.dll
                            test ! -f /app/appsettings.Development.json
                            test ! -f /app/appsettings.Local.json
                            dotnet --list-runtimes
                        '

                    echo "PASS: application images built for commit $tag; no deployment performed."
                '''
            }
        }
        stage('Docker smoke test') {
            steps {
                sh 'bash scripts/test-docker-smoke.sh'
            }
        }
        stage('Deploy EC2 preview') {
            when { expression { params.DEPLOY_EC2_PREVIEW } }
            steps {
                withCredentials([sshUserPrivateKey(
                    credentialsId: 'genzfashion-ec2-ssh',
                    keyFileVariable: 'EC2_KEY',
                    usernameVariable: 'EC2_USER'
                )]) {
                    withEnv(["EC2_HOST=${params.EC2_HOST}"]) {
                        sh 'bash scripts/deploy-ec2-preview.sh'
                    }
                }
            }
        }
    }

    post {
        success {
            echo 'SUCCESS: frontend tests/build, backend build/publish, image builds and isolated Docker smoke test passed.'
        }
        failure {
            echo 'FAILED: inspect Console Output for the failing stage.'
        }
    }
}
