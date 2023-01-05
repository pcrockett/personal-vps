#!/usr/bin/env bash

__zip_name="mullvad.zip"
__state_zip="${STATE_DIR}/${__zip_name}"
__state_extract_dir="${STATE_DIR}/mullvad"
__etc_wireguard_mullvad_dir="/etc/wireguard/mullvad"
__state_hash_file="${STATE_DIR}/config-placed-state"

# shellcheck disable=2034
dependencies=(
    mullvad-config-uploaded
)

reached_if() {
    file_is_unchanged "${__state_hash_file}"
}

apply() {
    rm --recursive --force "${__state_extract_dir}"
    (
        umask go-rwx
        unzip "${__state_zip}" -d "${__state_extract_dir}"
    )
    chown -R root:root "${__state_extract_dir}"
    sudo rm --recursive --force "${__etc_wireguard_mullvad_dir}"
    sudo mv "${__state_extract_dir}" "${__etc_wireguard_mullvad_dir}"

    sha256sum "${__state_zip}" > "${__state_hash_file}"
    set_file_unchanged "${__state_hash_file}"
}
