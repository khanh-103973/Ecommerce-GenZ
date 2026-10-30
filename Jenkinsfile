pipeline {
    agent { label 'ubuntu-docker' }

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
    }

    post {
        success {
            echo 'SUCCESS: frontend tests/build and backend build/publish passed.'
        }
        failure {
            echo 'FAILED: inspect Console Output for the failing stage.'
        }
    }
}
