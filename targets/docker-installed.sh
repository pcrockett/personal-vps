#!/usr/bin/env bash

# shellcheck disable=2034
dependencies=(
    docker-repo-configured
    lib/apt-updated
)

# From https://docs.docker.com/engine/install/debian/#install-using-the-repository
__packages=(
    docker-ce
    docker-ce-cli
    containerd.io
    docker-buildx-plugin
    docker-compose-plugin
)

reached_if() {
    for p in "${__packages[@]}"
    do
        package_is_installed "${p}"
    done
}

apply() {
    apt_install "${__packages[@]}"
}

#
# To reset a broken Docker install:
#
# $ sudo apt purge docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-ce-rootless-extras
# $ sudo apt autoremove --purge
# $ sudo rm -rf /var/lib/docker
# $ sudo rm -rf /var/lib/containerd
# $ sudo rm -rf /usr/local/lib/docker
#
# Then reinstall.
#
# Thanks to:
#
#    https://stackoverflow.com/a/42265926
#
# and
#
#    https://docs.docker.com/engine/install/ubuntu/#uninstall-docker-engine
#
