#!/usr/bin/env bash

# shellcheck disable=2034
dependencies=(
    is-connected-via-tailscale
)

__firewall_script__="${CONFIG_DIR}/reset-firewall.sh"

reached_if() {
    file_is_unchanged "${__firewall_script__}"
}

apply() {
    sudo "${__firewall_script__}"
    set_file_unchanged "${__firewall_script__}"
}
