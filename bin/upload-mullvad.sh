#!/usr/bin/env bash

set -Eeuo pipefail

readonly MULLVAD_ZIP="mullvad.zip"

panic() {
    echo "${@}"
    exit 1
}

test -f "${MULLVAD_ZIP}" || panic "Not found: ${MULLVAD_ZIP}"

sftp "${SSH_DEST}" <<EOF
cd configuration/.state
put ${MULLVAD_ZIP}
EOF
