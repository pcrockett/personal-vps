#!/usr/bin/env bash
set -Eeuo pipefail

# This script is meant for running at boot-time. Use `reset-firewall.sh` if you want to setup firewall rules when the
# machine is already running.

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
