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
THIS_DIR="$(dirname "$(readlink -f "${0}")")"
"${THIS_DIR}/firewall.sh"

service_exists() {
    local service_name="${1}"
    systemctl list-unit-files --full --type=service | grep --fixed-strings "${service_name}.service" &> /dev/null
}

# Tailscale modifies our packet filtering rules to enable exit node functionality, etc. We just blew those away, so we
# need to restart the service.
if service_exists tailscaled; then
    systemctl restart tailscaled
fi
