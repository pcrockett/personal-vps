#!/usr/bin/env bash

# shellcheck disable=2034
dependencies=()

__bottom_dir=~/.config/bottom

reached_if() {
    test -L "{$__bottom_dir}/bottom.toml"
}

apply() {
    mkdir --parent "${__bottom_dir}"
    rm --force "${__bottom_dir}/bottom.toml"
    ln --symbolic "${REPO_DIR}/config/bottom.toml" "${__bottom_dir}/bottom.toml"
}
