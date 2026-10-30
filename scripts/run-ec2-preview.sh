#!/usr/bin/env bash
# Remote EC2 runner; secrets are read by Compose from EC2, never copied to Jenkins.
set +x
set -euo pipefail
tag="${1:?Image tag required}"
checksum="${2:?Archive checksum required}"
[[ "$tag" =~ ^[0-9a-f]{12}$ && "$checksum" =~ ^[0-9a-f]{64}$ ]] || exit 1
cd "/home/ubuntu/genzfashion-deploy/releases/$tag"
printf '%s  images.tar\n' "$checksum" | sha256sum -c -
sudo -n docker image load -i images.tar

compose() {
    sudo -n env GENZFASHION_IMAGE_TAG="$tag" GENZFASHION_WEB_PORT=18083 \
        docker compose -p genzfashion-ec2-deploy \
        --env-file /home/ubuntu/genzfashion-deploy/.env \
        -f compose.preview.yaml "$@"
}
compose config --quiet
compose up -d --no-build

live_ok=false
for attempt in {1..30}; do
    if [[ "$(curl -fsS --max-time 3 http://127.0.0.1:18083/api/health/live 2>/dev/null || true)" == Healthy ]]; then
        live_ok=true
        break
    fi
    sleep 2
done
[[ "$live_ok" == true ]] || { echo 'ERROR: EC2 liveness check failed.' >&2; exit 1; }
[[ "$(curl -sS -o /dev/null -w '%{http_code}' --max-time 15 http://127.0.0.1:18083/api/health/ready)" == 503 ]]
[[ "$(curl -sS -o /dev/null -w '%{http_code}' --max-time 10 http://127.0.0.1:18083/shop)" == 200 ]]
[[ "$(curl -sS -o /dev/null -w '%{http_code}' --max-time 10 http://127.0.0.1:18083/api/auth/me)" == 401 ]]
printf '%s\n' "$tag" > /home/ubuntu/genzfashion-deploy/deployed-preview-tag
rm -- images.tar
echo "PASS: EC2 preview deployed ($tag), loopback port 18083; SQL intentionally unavailable (readiness 503)."
