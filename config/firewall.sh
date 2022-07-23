#!/usr/bin/env bash
set -Eeuo pipefail

yes | ufw reset
ufw default deny incoming
ufw allow proto tcp from any to any port 22
yes | ufw enable
