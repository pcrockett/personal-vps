#!/usr/bin/env bash

secure_random_hex() {
    local byte_count="${1:-16}"
    # byte_count must be a multiple of 4

    # Inspired by https://stackoverflow.com/a/34329799
    od --read-bytes "${byte_count}" "--width=${byte_count}" --output-duplicates --address-radix n --format x /dev/urandom \
        | tr --delete " "
}
