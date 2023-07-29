#!/usr/bin/env bash

# shellcheck disable=2034
dependencies=(
    pipx-installed
)

__package_name="TODO"

reached_if() {
    pipx list --short | grep --fixed-strings --word-regexp "${__package_name}"
}

apply() {
    pipx install "${__package_name}"
}
