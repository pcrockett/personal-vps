#!/usr/bin/env bash
set -Eeuo pipefail

# Start fresh, make sure failures in this script don't lock us out of our server
iptables --policy INPUT ACCEPT
ip6tables --policy INPUT ACCEPT
iptables --flush
ip6tables --flush
iptables --delete-chain
ip6tables --delete-chain

# Allow localhost processes to talk
iptables --append INPUT --in-interface lo --jump ACCEPT
ip6tables --append INPUT --in-interface lo --jump ACCEPT

# Allow remote machines to respond to us when we talk to them
iptables --append INPUT --match conntrack --ctstate RELATED,ESTABLISHED --jump ACCEPT

# SSH
iptables --append INPUT --protocol tcp --dport 22 --in-interface tailscale0 --jump ACCEPT

# This makes Tailscale direct connections possible: https://tailscale.com/kb/1082/firewall-ports/
iptables --append INPUT --protocol udp --dport 41641 --jump ACCEPT

iptables --append INPUT --jump REJECT
ip6tables --append INPUT --jump REJECT
iptables --policy INPUT DROP
ip6tables --policy INPUT DROP
iptables --policy FORWARD DROP
ip6tables --policy FORWARD DROP

service_exists() {
    local service_name="${1}"
    systemctl list-unit-files --full --type=service | grep --fixed-strings "${service_name}.service" &> /dev/null
}

# Tailscale modifies our packet filtering rules to enable exit node functionality, etc. We just blew those away, so we
# need to restart the service.
if service_exists tailscaled; then
    systemctl restart tailscaled
fi
