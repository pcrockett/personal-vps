#!/usr/bin/env bash

# shellcheck disable=2034
dependencies=(
    with-umask-installed
    apt-transport-https-installed
)

# If you're curious about the sources.list file format: `man 5 sources.list`

__product_name="TODO"
__list_uri="https://TODO.example/TODO"
__list_suites_and_components="TODO"
__key_url="TODO"
__key_file="/usr/share/keyrings/${__product_name}.gpg"
__list_file="/etc/apt/sources.list.d/${__product_name}.list"
__list_contents="deb [ signed-by=${__key_file} ] ${__list_uri} ${__list_suites_and_components}"

reached_if() {
    test -f "${__key_file}" \
        && grep --line-regexp --fixed-strings "${__list_contents}" "${__list_file}"
}

apply() {
    # Depending on the key format, the following `gpg --dearmor` may not be necessary
    curl_download "${__key_url}" \
        | gpg --dearmor \
        | sudo with-umask u=rw,g=r,o=r dd "of=${__key_file}" status=none
    echo "${__list_contents}" | sudo with-umask u=rw,g=r,o=r dd "of=${__list_file}" status=none
}
