#!/usr/bin/env bash

# shellcheck disable=2034
dependencies=(
    is-connected-via-tailscale
    firewall-script-installed
    firewall-service-installed
)

apply() {
    sudo "${CONFIG_DIR}/reset-firewall.sh"
}
