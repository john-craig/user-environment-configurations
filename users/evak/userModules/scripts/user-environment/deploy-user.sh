#!/bin/bash

EXTRA_ARGS=""
EXTRA_ARGS="${EXTRA_ARGS} --override-input nixpkgs-apocrypha ${NIXPKGS_APOCRYPHA}"

TARGET_USER=$1
TARGET_HOST=$2

if [[ -z $TARGET_USER ]]; then
    echo "No target user specified, default to current user"
    TARGET_USER=$USER
fi

if [[ -z $TARGET_HOST ]]; then
    echo "No target host specified, defaulting to current host"
    TARGET_HOST=$(hostname)
fi

USER_ENVIRONMENT_CONFIGURATIONS=$HOME/programming/by_category/user_environment/user-environment-configurations

home-manager switch -b bak --flake "$USER_ENVIRONMENT_CONFIGURATIONS#$TARGET_USER@$TARGET_HOST" ${EXTRA_ARGS}