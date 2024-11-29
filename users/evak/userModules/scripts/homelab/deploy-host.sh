#!/bin/bash

DEV_MODE=false
EXTRA_ARGS=""

for arg in "$@"; do
  case "$arg" in
    --dev)
      DEV_MODE=true
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

if [[ $DEV_MODE == true ]]; then
  DISMAS_OVERLAYS=$(readlink $HOME/.config/dismas/overlays)

  EXTRA_ARGS="${EXTRA_ARGS} --fast"
  EXTRA_ARGS="${EXTRA_ARGS} --impure"
  EXTRA_ARGS="${EXTRA_ARGS} --override-input nixpkgs-apocrypha ${NIXPKGS_APOCRYPHA}"
  EXTRA_ARGS="${EXTRA_ARGS} --override-input gallipedal ${GALLIPEDAL_MODULE}"
  EXTRA_ARGS="${EXTRA_ARGS} --override-input gallipedal/gallipedal-library ${GALLIPEDAL_SERVICES}"
  
  nixos-rebuild switch --flake "${HOMELAB_CONFIGURATIONS}#${TARGET_HOST}" \
      --target-host "${TARGET_HOST}" --build-host "${TARGET_HOST}" \
      --use-remote-sudo ${EXTRA_ARGS}
  
  # rm $HOME/.config/nixpkgs/overlays
else
  nixos-rebuild switch --flake "${HOMELAB_CONFIGURATIONS}#${TARGET_HOST}" \
      --target-host "${TARGET_HOST}" --build-host "${TARGET_HOST}" \
      --use-remote-sudo ${EXTRA_ARGS}
  ssh "${TARGET_HOST}" "sudo nix-collect-garbage"
fi