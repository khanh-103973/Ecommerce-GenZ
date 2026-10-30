#!/usr/bin/env bash
# Run on the Jenkins agent after image builds and smoke tests pass.
set +x
set -euo pipefail

: "${EC2_KEY:?Jenkins SSH credential required}"
: "${EC2_USER:?Jenkins SSH username required}"
: "${EC2_HOST:?EC2 IPv4 required}"
[[ "$EC2_HOST" =~ ^[0-9]{1,3}(\.[0-9]{1,3}){3}$ ]] || {
    echo 'ERROR: EC2_HOST must be a public IPv4 address.' >&2
    exit 1
}
[[ "$EC2_USER" == ubuntu ]] || { echo 'ERROR: Expected EC2 user ubuntu.' >&2; exit 1; }

tag="$(git rev-parse --short=12 HEAD)"
transfer_dir="$(mktemp -d)"
trap 'rm -f -- "$transfer_dir/images.tar"; rmdir -- "$transfer_dir"' EXIT
ssh_options=(-i "$EC2_KEY" -o BatchMode=yes -o IdentitiesOnly=yes
    -o StrictHostKeyChecking=yes -o ConnectTimeout=10)
target="$EC2_USER@$EC2_HOST"

# Fail before exporting/uploading if credentials or persistent config are missing.
ssh "${ssh_options[@]}" "$target" '
    set -eu
    test -s /home/ubuntu/genzfashion-deploy/.env
    test "$(stat -c %a /home/ubuntu/genzfashion-deploy/.env)" = 600
    test "$(stat -c %U /home/ubuntu/genzfashion-deploy/.env)" = ubuntu
    sudo -n docker info >/dev/null
    mkdir -p /home/ubuntu/genzfashion-deploy/releases
    chmod 700 /home/ubuntu/genzfashion-deploy/releases
'
docker image save -o "$transfer_dir/images.tar" "genzfashion-api:$tag" "genzfashion-web:$tag"
checksum="$(sha256sum "$transfer_dir/images.tar" | cut -d ' ' -f 1)"
ssh "${ssh_options[@]}" "$target" "mkdir -p /home/ubuntu/genzfashion-deploy/releases/$tag"
scp "${ssh_options[@]}" "$transfer_dir/images.tar" compose.preview.yaml \
    scripts/run-ec2-preview.sh "$target:/home/ubuntu/genzfashion-deploy/releases/$tag/"
ssh "${ssh_options[@]}" "$target" \
    "bash /home/ubuntu/genzfashion-deploy/releases/$tag/run-ec2-preview.sh '$tag' '$checksum'"
