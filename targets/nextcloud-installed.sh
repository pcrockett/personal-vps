#!/usr/bin/env bash

# https://github.com/nextcloud/all-in-one
#
# I hate this all-in-one setup. I don't like giving Docker full control over my VPS.
# That said, I ain't got time right now to do it "the right way," and we're going to
# firewall this bad boy off so it's only reachable via tailscale.
#
# Tech debt! Woot!

# shellcheck disable=2034
dependencies=(
    docker-installed
)

# This name MUST NOT CHANGE, according to the docs
__aio_container_name=nextcloud-aio-mastercontainer

reached_if() {
    docker container exists "${__aio_container_name}"
}

apply() {
    docker run \
        --sig-proxy=false \
        --name "${__aio_container_name}" \
        --restart always \
        --publish 80:80 \
        --publish 8080:8080 \
        --publish 8443:8443 \
        --volume nextcloud_aio_mastercontainer:/mnt/docker-aio-config \
        --volume //var/run/docker.sock:/var/run/docker.sock:ro \
        nextcloud/all-in-one:latest
}
