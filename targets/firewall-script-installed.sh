#!/usr/bin/env bash

# shellcheck disable=2034
dependencies=(
    is-connected-via-tailscale
)

__firewall_script_src="${CONFIG_DIR}/firewall.sh"

reached_if() {
    file_is_unchanged "${__firewall_script_src}" \
        && command_is_installed firewall.sh
}

apply() {
    sudo cp "${__firewall_script_src}" /usr/local/bin/
    sudo "${CONFIG_DIR}/reset-firewall.sh"
    set_file_unchanged "${__firewall_script_src}"
}
