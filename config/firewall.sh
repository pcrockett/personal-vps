#!/usr/bin/env bash
set -Eeuo pipefail

ufw reset
ufw default deny incoming
ufw allow proto tcp from any to any port 22
ufw enable
