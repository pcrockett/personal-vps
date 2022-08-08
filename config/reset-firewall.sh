#!/usr/bin/env bash
set -Eeuo pipefail

# This script is meant for running interactively, after the machine is booted.

# Start fresh, make sure failures in this script don't lock us out of our server
iptables --policy INPUT ACCEPT
ip6tables --policy INPUT ACCEPT
iptables --flush
ip6tables --flush
iptables --delete-chain
ip6tables --delete-chain

# Run the normal firewall script
firewall.sh

services_to_restart=(
    tailscaled
)

service_exists() {
    local service_name="${1}"
    systemctl list-unit-files --full --type=service | grep --fixed-strings "${service_name}.service" &> /dev/null
}

service_is_running() {
    test "$(systemctl is-active "${1}")" == "active"
}

restart_if_needed() {
    local service_name="${1}"
    if service_exists "${service_name}" && service_is_running "${service_name}"; then
        systemctl restart "${service_name}"
    fi
}

for service_name in "${services_to_restart[@]}"; do
    restart_if_needed "${service_name}"
done
