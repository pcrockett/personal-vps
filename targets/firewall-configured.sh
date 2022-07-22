#!/usr/bin/env bash

# shellcheck disable=2034
dependencies=()

__firewall_script__="${CONFIG_DIR}/firewall.sh"

reached_if() {
    file_is_unchanged "${__firewall_script__}"
}

apply() {
    sudo "${__firewall_script__}"
    set_file_unchanged "${__firewall_script__}"
}
