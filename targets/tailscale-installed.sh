#!/usr/bin/env bash

# shellcheck disable=2034
dependencies=(
    tailscale-repo-configured
)

reached_if() {
    command_is_installed tailscale
}

apply() {
    apt_install tailscale
}
