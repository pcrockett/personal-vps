#!/usr/bin/env bash

# shellcheck disable=2034
dependencies=()

__list_file="/etc/apt/sources.list.d/docker.list"
__keyring_file="/usr/share/keyrings/docker.gpg"

reached_if() {
    test -f "${__list_file}"
}

apply() {
    # From https://docs.docker.com/engine/install/debian/#install-using-the-repository
    # and [[apt-key deprecated 2021-11-02]]
    curl_download https://download.docker.com/linux/ubuntu/gpg \
        | gpg --dearmor \
        | dump_as_root "${__keyring_file}"
    echo "deb [ arch=$(dpkg --print-architecture) signed-by=${__keyring_file} ] https://download.docker.com/linux/ubuntu $(lsb_release --codename --short) stable" \
        | dump_as_root "${__list_file}"
}
