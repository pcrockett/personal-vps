#!/usr/bin/env bash
set -Eeuo pipefail

# Start fresh
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
iptables --append INPUT --protocol tcp --dport 22 --jump ACCEPT

# This makes Tailscale direct connections possible: https://tailscale.com/kb/1082/firewall-ports/
# iptables --append INPUT --protocol udp --dport 41641 --jump ACCEPT

iptables --policy INPUT DROP
ip6tables --policy INPUT DROP
iptables --policy FORWARD DROP
ip6tables --policy FORWARD DROP

