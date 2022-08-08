#!/usr/bin/env bash

# shellcheck disable=2034
dependencies=()

reached_if() {
    local auth_keys_hash
    auth_keys_hash="$(echo "${LC_AUTHORIZED_KEYS}" | get_hash)"
    test "${auth_keys_hash}" == "$(get_file_hash ~/.ssh/authorized_keys)"
}

apply() {
    echo "${LC_AUTHORIZED_KEYS}" > ~/.ssh/authorized_keys
}
