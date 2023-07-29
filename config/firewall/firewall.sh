#!/usr/bin/env bash
set -Eeuo pipefail

# This script is meant for running at boot-time. Use `reset-firewall.sh` if you want to setup firewall rules when the
# machine is already running.

# Allow localhost processes to talk
iptables --append INPUT --in-interface lo --jump ACCEPT
ip6tables --append INPUT --in-interface lo --jump ACCEPT

# Allow remote machines to respond to us when we talk to them
iptables --append INPUT --match conntrack --ctstate RELATED,ESTABLISHED --jump ACCEPT

allow_tailscale() {
    local port="${1}"
    local protocol="${2:-tcp}"
    iptables --append INPUT --protocol "${protocol}" --dport "${port}" --in-interface tailscale0 --jump ACCEPT
}

allow_public() {
    local port="${1}"
    local protocol="${2:-tcp}"
    iptables --append INPUT --protocol "${protocol}" --dport "${port}" --jump ACCEPT
}

# SSH
allow_tailscale 22 tcp

# Nextcloud
# https://github.com/nextcloud/all-in-one#explanation-of-used-ports
allow_public 80 tcp       # PUBLIC: allows retrieval of ACME TLS certificates
allow_tailscale 8080 tcp  # master container interface
allow_tailscale 8443 tcp  # master container interface with valid cert
allow_tailscale 443 tcp   # main nextcloud interface
# allow_public 443 tcp  # need this ONLY TEMPORARILY? to get through the setup phase
                        # can also manually run something like `iptables --insert INPUT --protocol tcp --dport 443 --jump ACCEPT`
allow_tailscale 443 udp   # main nextcloud interface (http3)
allow_tailscale 3478 tcp  # TURN
allow_tailscale 3478 udp  # TURN

# This makes Tailscale direct connections possible: https://tailscale.com/kb/1082/firewall-ports/
allow_public 41641 udp

iptables --append INPUT --jump REJECT
ip6tables --append INPUT --jump REJECT
iptables --policy INPUT DROP
ip6tables --policy INPUT DROP
iptables --policy FORWARD DROP
ip6tables --policy FORWARD DROP