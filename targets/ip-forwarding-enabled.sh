#!/usr/bin/env bash

# shellcheck disable=2034
dependencies=()

__ip_forward_setting="net.ipv4.ip_forward = 1"
__conf_file="/etc/sysctl.conf"

reached_if() {
    grep --line-regexp --fixed-strings "${__ip_forward_setting}" "${__conf_file}"
}

apply() {
    echo "${__ip_forward_setting}" | sudo tee --append "${__conf_file}"
    sudo sysctl --load "${__conf_file}"
}
