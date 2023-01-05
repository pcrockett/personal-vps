#!/usr/bin/env bash

__zip_name="mullvad.zip"
__state_zip="${STATE_DIR}/${__zip_name}"

# shellcheck disable=2034
dependencies=()

reached_if() {
    file_is_unchanged "${__state_zip}"
}

apply() {
    if [ ! -f "${__state_zip}" ]; then
        log_success "
Go to the following URL to generate your Wireguard config:

https://mullvad.net/en/account/#/wireguard-config

Save that file to your controller PC at the repo root with the name \`${__zip_name}\`.

Then resume the process with \`make upload-mullvad deploy\`
"
        false
    else
        set_file_unchanged "${__state_zip}"
    fi
}
