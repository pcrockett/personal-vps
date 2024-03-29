#!/usr/bin/env bash

# This is the target that will run when you don't specify any targets on the command line. Add targets to the
# dependencies list to make those run by default as well.

# shellcheck disable=2034
dependencies=(
    initial-upgrade
    hostname-set
    password-changed
    ssh-authorized-keys-configured
    tailscale-up
    firewall-configured
    usecases/admin
    usecases/nextcloud
)
