#!/usr/bin/env bash

# shellcheck disable=2034
dependencies=(
    firewall-script-installed
)

__svc_file="${CONFIG_DIR}/firewall.service"

reached_if() {
    service_enabled firewall \
        && file_is_unchanged "${__svc_file}"
}

apply() {
    sudo cp "${__svc_file}" /etc/systemd/system/firewall.service
    sudo systemctl daemon-reload
    sudo systemctl enable firewall  # Intentionally excluding `--now`; only want this to run at boot.
    set_file_unchanged "${__svc_file}"
}
