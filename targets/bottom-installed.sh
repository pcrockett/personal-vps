#!/usr/bin/env bash

# shellcheck disable=2034
dependencies=(
    bottom-downloaded
    bottom-configured
)

reached_if() {
    command_is_installed btm
}

apply() {
    sudo dpkg --install "${STATE_DIR}/${BOTTOM_DEB_FILE_NAME}"
}
