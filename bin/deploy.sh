#!/usr/bin/env bash
set -Eeuo pipefail

git push server
ssh "${SSH_DEST}" << EOF
cd ./configuration && \
git reset --hard main && \
./run.sh
EOF
