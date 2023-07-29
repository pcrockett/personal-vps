#!/usr/bin/env bash

# shellcheck disable=2034
dependencies=(
    docker-installed
)

__group_name=docker

reached_if() {
    groups | grep --fixed-strings --word-regexp "${__group_name}"
}

apply() {
    sudo usermod --append --groups "${__group_name}" "${USER}"
    log_success "Added ${USER} to the ${__group_name} group. You must log out for changes to take effect."
    exit 1
}
