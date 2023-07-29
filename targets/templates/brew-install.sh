#!/usr/bin/env bash

# shellcheck disable=2034
dependencies=(
    brew-updated
)

__package_name="TODO"

reached_if() {
    brew list "${__package_name}"
}

apply() {
    brew install "${__package_name}"
}
