#!/bin/bash

TARGET_HOST=$1

if [[ -z $TARGET_HOST ]]; then
    echo "Must specify a target host"
    exit 1
fi

NIX_SSHOPTS="-i ~/.ssh/bootstrapper" \
nixos-rebuild switch --flake "${HOMELAB_CONFIGURATIONS}#${TARGET_HOST}" \
    --target-host "bootstrapper@${TARGET_HOST}" --build-host "bootstrapper@${TARGET_HOST}" \
    --use-remote-sudo