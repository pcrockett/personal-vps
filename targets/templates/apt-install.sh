#!/usr/bin/env bash

# shellcheck disable=2034
dependencies=(
    lib/apt-updated
)

__package_name="TODO"

reached_if() {
    package_is_installed "${__package_name}"
}

apply() {
    apt_install "${__package_name}"
}
