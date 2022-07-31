#!/usr/bin/env bash

# shellcheck disable=2034
dependencies=(
    tailscale-installed
)

reached_if() {
    tailscale status && [[ "${SSH_CLIENT}" =~ ^100\. ]]
}

apply() {
    log_error "It looks like you're not connected via the VPN. Reconnect using the $(tailscale ip -4) IP and try again."
    exit 1
}
