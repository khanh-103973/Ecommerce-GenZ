#!/usr/bin/env bash
# Run from the repository root on the Jenkins Docker agent.
set -eu
set +x
tag="$(git rev-parse --short=12 HEAD)"
prefix="genzfashion-ci-${BUILD_NUMBER:-local}-$$"
network="$prefix-net"
api="$prefix-api"
web="$prefix-web"
network_created=0
api_created=0
web_created=0

cleanup() {
    result=$?
    trap - EXIT
    if [ "$web_created" = 1 ]; then docker rm -f "$web" >/dev/null || true; fi
    if [ "$api_created" = 1 ]; then docker rm -f "$api" >/dev/null || true; fi
    if [ "$network_created" = 1 ]; then docker network rm "$network" >/dev/null || true; fi
    unset Jwt__SigningKey
    exit "$result"
}
trap cleanup EXIT
trap 'exit 130' INT
trap 'exit 143' TERM

# No host ports and no external network access for these temporary containers.
docker network create --internal "$network" >/dev/null
network_created=1
export Jwt__SigningKey="$(od -An -N32 -tx1 /dev/urandom | tr -d ' \n')"
docker run -d --name "$api" --network "$network" --network-alias api \
    -e Jwt__SigningKey \
    -e 'ConnectionStrings__GenZFashionDb=Server=tcp:127.0.0.1,1;Database=GenZFashionDb;Integrated Security=True;Encrypt=True;Connect Timeout=1;ConnectRetryCount=0' \
    "genzfashion-api:$tag" >/dev/null
api_created=1
unset Jwt__SigningKey
docker run -d --name "$web" --network "$network" --network-alias web \
    "genzfashion-web:$tag" >/dev/null
web_created=1

docker run --rm -i --network "$network" node:24-bookworm-slim \
    node --input-type=module < scripts/docker-smoke-client.mjs
echo 'PASS: isolated Docker smoke test; database intentionally unavailable; temporary services will be removed.'
