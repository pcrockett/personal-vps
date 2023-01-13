#!/usr/bin/env bash

######################################################################################################################
# DANGER DANGER WILL ROBINSON
#
# This target kills your network connections. It'll force you to reboot your server at least. To get it working, you
# will probably need to try some solution mentioned here:
#
#     https://github.com/tailscale/tailscale/issues/925
#
# tl;dr: Tailscale and Mullvad don't cooperate, and you'll need to fiddle with iptables / routes to get it right.
#
# Another approach worth trying: Use Mullvad's split tunneling feature. That may require using the CLI and doing other
# hacky crimes.
#
#     https://mullvad.net/en/help/how-use-mullvad-cli/#split-linux
#
######################################################################################################################

# shellcheck disable=2034
dependencies=(
    mullvad-config-placed
)

reached_if() {
    service_exists wg-quick@
    test "$(systemctl is-active wg-quick@wg0)" == "active"
}

apply() {
    random_config="$(sudo find /etc/wireguard/mullvad/ -maxdepth 1 -mindepth 1 -name "*.conf" | shuf --head-count 1)"

    # We don't configure DNS the way wg-quick does. Delete the DNS line from the config:
    sudo sed "s/^DNS.*\$//" "${random_config}" | sudo tee /etc/wireguard/wg0.conf > /dev/null

    sudo systemctl start wg-quick@wg0.service
}
