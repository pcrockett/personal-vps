#!/usr/bin/env bash

# shellcheck disable=2034
dependencies=(
    lib/apt-updated
)

apply() {
    sudo apt-get upgrade --yes
}
