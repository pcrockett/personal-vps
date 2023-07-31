#!/usr/bin/env bash

# shellcheck disable=2034
dependencies=(
    nextcloud-service-installed
)

__script_name="occ"
__repo_file_location="${REPO_DIR}/config/nextcloud/${__script_name}"
__install_dir="/usr/local/bin"

reached_if() {
    test -x "${__install_dir}/${__script_name}" \
        && file_is_unchanged "${__repo_file_location}"
}

apply() {
    sudo install "${__repo_file_location}" "${__install_dir}"
    set_file_unchanged "${__repo_file_location}"
}
