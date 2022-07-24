#!/usr/bin/env bash
set -Eeuo pipefail

# This script is from https://tailscale.com/download/linux/ubuntu-2204
# It's intended more for documentation purposes; It shows exactly where we got our assets from.

THIS_DIR="$(dirname "$(readlink -f "${0}")")"

download_file() {
    local url="${1}"
    curl --fail --silent --show-error --location "${url}"
}

download_file https://pkgs.tailscale.com/stable/ubuntu/jammy.noarmor.gpg > "${THIS_DIR}/jammy.noarmor.gpg"
download_file https://pkgs.tailscale.com/stable/ubuntu/jammy.tailscale-keyring.list > "${THIS_DIR}/jammy.tailscale-keyring.list"
