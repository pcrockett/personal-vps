#!/usr/bin/env bash

# shellcheck disable=2034
dependencies=(
    tailscale-installed
    ip-forwarding-enabled
)

reached_if() {
    tailscale status
}

apply() {
    sudo tailscale up \
        --advertise-exit-node \
        --authkey "${LC_TAILSCALE_AUTH_KEY}" \
        --hostname "${SERVER_HOSTNAME}"
}
