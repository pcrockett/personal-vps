#!/usr/bin/env bash

# shellcheck disable=2034
dependencies=()

reached_if() {
    test "$(hostnamectl hostname)" == "${SERVER_HOSTNAME}"
}

apply() {
    sudo hostnamectl hostname "${SERVER_HOSTNAME}"
}
