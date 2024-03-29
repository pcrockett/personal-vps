#!/usr/bin/env bash

# shellcheck disable=2034
dependencies=(
    docker-installed
    docker-group-added
)

# https://github.com/nextcloud/all-in-one
#
# I hate this all-in-one setup. I don't like giving Docker full control over my VPS.
# That said, I ain't got time right now to do it "the right way," and we're going to
# firewall this bad boy off so it's only reachable via tailscale.
#
# Tech debt! Woot!

# According to docs, this cannot be customized, or it'll break (for example) updates
__aio_container_name=nextcloud-aio-mastercontainer

# TODO: look up this IP up dynamically?
__tailscale_ip=100.90.64.115

reached_if() {
    docker container inspect "${__aio_container_name}" &> /dev/null
}

apply() {
    docker container create \
        --name "${__aio_container_name}" \
        --restart no \
        --publish 80:80 \
        --publish "${__tailscale_ip}:8080:8080" \
        --publish "${__tailscale_ip}:8443:8443" \
        --volume nextcloud_aio_mastercontainer:/mnt/docker-aio-config \
        --volume /var/run/docker.sock:/var/run/docker.sock:ro \
        nextcloud/all-in-one:latest
}
