#!/usr/bin/env bash
set -Eeuo pipefail

ufw reset
ufw default deny incoming
ufw allow in from any port 22
ufw enable
