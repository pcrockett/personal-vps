#!/usr/bin/env bash
set -Eeuo pipefail

ssh "${SSH_DEST}" << EOF
test -d ./configuration || git init --initial-branch main ./configuration
cd configuration
git config --local receive.denyCurrentBranch ignore
EOF
git remote add server "${SSH_DEST}:configuration"
git push --set-upstream server main:main
