#!/usr/bin/env bash

# shellcheck disable=2034
dependencies=()

__link_name="TODO"
__repo_location="${REPO_CONFIG_DIR}/${__link_name}"
__dest_location="${HOME}/.config/${__link_name}"

reached_if() {
    test_symlink "${__repo_location}" "${__dest_location}"
}

apply() {
    ensure_symlink "${__repo_location}" "${__dest_location}"
}
