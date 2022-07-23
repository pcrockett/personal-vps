#!/usr/bin/env bash

# shellcheck disable=2034
dependencies=(
    software-update
)

reached_if() {
    test -f "${STATE_DIR}/initial-upgrade-completed"
}

apply() {
    touch "${STATE_DIR}/initial-upgrade-completed"
    log_success "Initial upgrade completed. Recommended: reboot and re-run."
    exit 1
}
