#!/usr/bin/env bash

# shellcheck disable=2034
dependencies=(tailscale-installed)

reached_if() {
    tailscale status
}

apply() {
    tailscale up \
        --advertise-exit-node \
        --authkey "${LC_TAILSCALE_AUTH_KEY}" \
        --hostname "${SERVER_HOSTNAME}"
}
