#!/bin/bash

# Initialize variables
DEV_MODE=false
TARGET_USER=""
TARGET_HOST=""

# Process command-line arguments
while [[ $# -gt 0 ]]; do
    case "$1" in
        --dev)
            DEV_MODE=true
            shift # Move to the next argument
            ;;
        *)
            # Store the positional parameters
            if [[ -z "$TARGET_USER" ]]; then
                TARGET_USER="$1"
            elif [[ -z "$TARGET_HOST" ]]; then
                TARGET_HOST="$1"
            else
                echo "Too many arguments. Only TARGET_USER and TARGET_HOST are expected."
                exit 1
            fi
            shift # Move to the next argument
            ;;
    esac
done

if [[ -z $TARGET_USER ]]; then
    echo "No target user specified, default to current user"
    TARGET_USER=$USER
fi

if [[ -z $TARGET_HOST ]]; then
    echo "No target host specified, defaulting to current host"
    TARGET_HOST=$(hostname)
fi

USER_ENVIRONMENT_CONFIGURATIONS=$HOME/programming/by_category/user_environment/user-environment-configurations

EXTRA_ARGS=""

if [[ $DEV_MODE == true ]]; then
    EXTRA_ARGS="${EXTRA_ARGS} --override-input nixpkgs-apocrypha ${NIXPKGS_APOCRYPHA}"
    EXTRA_ARGS="${EXTRA_ARGS} --impure"

    ln -s $HOME/.config/dismas/overlays $HOME/.config/nixpkgs/overlays

    home-manager switch -b bak --flake "$USER_ENVIRONMENT_CONFIGURATIONS#$TARGET_USER@$TARGET_HOST" ${EXTRA_ARGS}

    rm $HOME/.config/nixpkgs/overlays
else
    home-manager switch -b bak --flake "$USER_ENVIRONMENT_CONFIGURATIONS#$TARGET_USER@$TARGET_HOST"
fi