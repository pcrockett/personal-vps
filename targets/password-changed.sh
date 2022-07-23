#!/usr/bin/env bash

# shellcheck disable=2034
dependencies=()

reached_if() {
    test -f "${STATE_DIR}/password-changed"
}

apply() {
    # We don't actually need to know the password; we have passwordless sudo.
    # I just don't like that OVH set my password for me.
    # Note that since `echo` is a Bash builtin, this shouldn't cause a password leak.
    echo "${USER}:$(secure_random_hex 32)" | sudo chpasswd
    touch "${STATE_DIR}/password-changed"
}
