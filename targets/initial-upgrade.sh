#!/usr/bin/env bash

# shellcheck disable=2034
dependencies=(
    lib/apt-updated
)

reached_if() {
    test -f "${STATE_DIR}/initial-upgrade-completed"
}

apply() {
    sudo apt-get upgrade --yes
    touch "${STATE_DIR}/initial-upgrade-completed"
    log_success "Initial upgrade completed. Recommended: reboot and re-run."
    exit 1
}
