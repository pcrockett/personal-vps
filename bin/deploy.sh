#!/usr/bin/env bash
set -Eeuo pipefail

git_cmd=(git push server)

if [ "${1:-}" == "--force" ]; then
    git_cmd+=("--force")
fi

"${git_cmd[@]}"
ssh "${SSH_DEST}" \
    -o SendEnv=LC_TAILSCALE_AUTH_KEY \
    -o SendEnv=LC_AUTHORIZED_KEYS \
<< EOF
cd ./configuration && \
git reset --hard main && \
./run.sh
EOF
