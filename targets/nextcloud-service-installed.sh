#!/usr/bin/env bash

# shellcheck disable=2034
dependencies=(
    docker-installed
    docker-group-added
    nextcloud-script-installed
)

__svc_file="${CONFIG_DIR}/nextcloud/nextcloud.service"

reached_if() {
    service_enabled nextcloud \
        && file_is_unchanged "${__svc_file}"
}

apply() {
    sudo cp "${__svc_file}" /etc/systemd/system/nextcloud.service
    sudo systemctl daemon-reload
    sudo systemctl enable nextcloud --now
    set_file_unchanged "${__svc_file}"
}
