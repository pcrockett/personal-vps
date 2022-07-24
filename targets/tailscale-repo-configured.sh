#!/usr/bin/env bash

# shellcheck disable=2034
dependencies=()

__tailscale_config_dir="${REPO_DIR}/config/tailscale"
__dest_key_file="/usr/share/keyrings/tailscale-archive-keyring.gpg"
__dest_list_file="/etc/apt/sources.list.d/tailscale.list"

reached_if() {
    file_is_unchanged "${__tailscale_config_dir}/jammy.noarmor.gpg" \
        && file_is_unchanged "${__tailscale_config_dir}/jammy.tailscale-keyring.list" \
        && test -f "${__dest_key_file}" \
        && test -f "${__dest_list_file}"
}

apply() {
    sudo cp "${__tailscale_config_dir}/jammy.noarmor.gpg" "${__dest_key_file}"
    sudo cp "${__tailscale_config_dir}/jammy.tailscale-keyring.list" "${__dest_list_file}"
    sudo apt-get update
}
