#!/usr/bin/env bash
set -Eeuo pipefail

# https://github.com/nextcloud/all-in-one
#
# I hate this all-in-one setup. I don't like giving Docker full control over my VPS.
# That said, I ain't got time right now to do it "the right way," and we're going to
# firewall this bad boy off so it's only reachable via tailscale.
#
# Tech debt! Woot!

docker run \
    --name nextcloud-aio-mastercontainer \
    --restart no \
    --publish 80:80 \
    --publish 8080:8080 \
    --publish 8443:8443 \
    --volume nextcloud_aio_mastercontainer:/mnt/docker-aio-config \
    --volume /var/run/docker.sock:/var/run/docker.sock:ro \
    nextcloud/all-in-one:latest
