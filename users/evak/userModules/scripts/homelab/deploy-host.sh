#!/bin/bash

EXTRA_ARGS=""
COLLECT_GARBAGE=1

for arg in "$@"; do
  case "$arg" in
    --dev)
      EXTRA_ARGS="${EXTRA_ARGS} --fast"
      EXTRA_ARGS="${EXTRA_ARGS} --override-input nixpkgs-apocrypha ${NIXPKGS_APOCRYPHA}"
      EXTRA_ARGS="${EXTRA_ARGS} --override-input gallipedal ${GALLIPEDAL_MODULE}"
      EXTRA_ARGS="${EXTRA_ARGS} --override-input gallipedal/gallipedal-library ${GALLIPEDAL_SERVICES}"
      COLLECT_GARBAGE=0
      ;;
    *)
      TARGET_HOST="$arg"
      ;;
  esac
done

if [[ -z $TARGET_HOST ]]; then
    echo "Must specify a target host"
    exit 1
fi

set -eo pipefail

nixos-rebuild dry-activate --flake "${HOMELAB_CONFIGURATIONS}#${TARGET_HOST}" \
    --target-host "${TARGET_HOST}" --build-host "${TARGET_HOST}" \
    --use-remote-sudo ${EXTRA_ARGS}

nixos-rebuild switch --flake "${HOMELAB_CONFIGURATIONS}#${TARGET_HOST}" \
    --target-host "${TARGET_HOST}" --build-host "${TARGET_HOST}" \
    --use-remote-sudo ${EXTRA_ARGS}

if [[ $COLLECT_GARBAGE -eq 1 ]]; then
    ssh "${TARGET_HOST}" "sudo nix-collect-garbage"
fi