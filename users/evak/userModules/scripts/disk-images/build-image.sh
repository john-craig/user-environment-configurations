#!/bin/bash

TARGET_IMAGE=$1

if [[ -z $TARGET_IMAGE ]]; then
    echo "Must specify a target host"
    exit 1
fi

nix build --out-link /tmp/image-result $DISK_IMAGE_CONFIGURATIONS#images.$TARGET_IMAGE