#!/usr/bin/env bash

# shellcheck disable=2034
dependencies=()

__flatpak_id="org.gnome.clocks"

reached_if() {
    flatpak_is_installed "${__flatpak_id}"
}

apply() {
    flathub_install "${__flatpak_id}"
}
