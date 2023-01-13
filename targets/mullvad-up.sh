#!/usr/bin/env bash

# shellcheck disable=2034
dependencies=(
    mullvad-config-placed
)

reached_if() {
    service_exists wg-quick@
    test "$(systemctl is-active wg-quick@wg0)" == "active"
}

apply() {
    random_config="$(sudo find /etc/wireguard/mullvad/ -maxdepth 1 -mindepth 1 -name "*.conf" | shuf | head --lines 1)"

    # We don't want Mullvad's DNS server:
    sudo sed "s/^DNS.*\$//" "${random_config}" | sudo tee /etc/wireguard/wg0.conf > /dev/null

    sudo systemctl start wg-quick@wg0.service
}
