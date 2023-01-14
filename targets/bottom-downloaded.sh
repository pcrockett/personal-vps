#!/usr/bin/env bash

# shellcheck disable=2034
dependencies=()

reached_if() {
    test -f "${STATE_DIR}/${BOTTOM_DEB_FILE_NAME}"
}

apply() {
    curl_download "https://github.com/ClementTsang/bottom/releases/download/${BOTTOM_VERSION}/${BOTTOM_DEB_FILE_NAME}" \
        > "${STATE_DIR}/${BOTTOM_DEB_FILE_NAME}.temp"
    mv "${STATE_DIR}/${BOTTOM_DEB_FILE_NAME}.temp" "${STATE_DIR}/${BOTTOM_DEB_FILE_NAME}"
}
