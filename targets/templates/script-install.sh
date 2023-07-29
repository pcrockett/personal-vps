#!/usr/bin/env bash

# shellcheck disable=2034
dependencies=()

__script_name="TODO"
__repo_file_location="${REPO_DIR}/scripts/${__script_name}"
__install_dir="/usr/local/bin"

reached_if() {
    test -x "${__install_dir}/${__script_name}" \
        && file_is_unchanged "${__repo_file_location}"
}

apply() {
    sudo install "${__repo_file_location}" "${__install_dir}"
    set_file_unchanged "${__repo_file_location}"
}
