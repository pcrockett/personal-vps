#!/usr/bin/env bash

# shellcheck disable=2034
dependencies=(
    mullvad-config-placed
)

reached_if() {
    service_enabled_and_active "wg-quick@wg0.service"
}

apply() {
    sudo rm --force /etc/wireguard/wg0.conf
    random_config="$(sudo find /etc/wireguard/mullvad/ -maxdepth 1 -mindepth 1 -name "*.conf" | shuf | head --lines 1)"
    sudo ln --symbolic "${random_config}" /etc/wireguard/wg0.conf
    sudo systemctl enable --now wg-quick@wg0.service
}
