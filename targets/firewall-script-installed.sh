#!/usr/bin/env bash

# shellcheck disable=2034
dependencies=()

__firewall_script_src="${REPO_DIR}/config/firewall.sh"

reached_if() {
    file_is_unchanged "${__firewall_script_src}" \
        && command_is_installed firewall.sh
}

apply() {
    sudo cp "${__firewall_script_src}" /usr/local/bin/
    sudo chown root:root "/usr/local/bin/firewall.sh"
    set_file_unchanged "${__firewall_script_src}"
}
