#!/usr/bin/env bash
set -Eeuo pipefail

git push server
ssh "${SSH_DEST}" -o SendEnv=LC_TAILSCALE_AUTH_KEY << EOF
cd ./configuration && \
git reset --hard main && \
./run.sh
EOF
