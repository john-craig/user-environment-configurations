#!/bin/bash
APPLICATION=$1
CONFIG_PATH=$2
TARGET_USER=$3

# TODO: Move this somewhere else
USER_ENVIRONMENT_CONFIGURATIONS=$HOME/programming/by_category/user_environment/user-environment-configurations

if [[ -z $APPLICATION ]]; then
    echo "Must specify an application name for the configuration file"
    exit 1
fi

if [[ -z $CONFIG_PATH ]]; then
    echo "Must specify a path for the configuration file"
    exit 1
fi

CONFIG_PATH=$(realpath $CONFIG_PATH)

if [[ ! -f $CONFIG_PATH ]]; then
    echo "Configuration file $CONFIG_PATH not found"
    exit 1
fi

if [[ -z $TARGET_USER ]]; then
    echo "No target user specified, defaulting to current user"
    TARGET_USER=$USER
fi

APP_DIR=$USER_ENVIRONMENT_CONFIGURATIONS/users/$TARGET_USER/userModules/applications

if [[ ! -d $APP_DIR/$APPLICATION ]]; then
    echo "No module for application $APPLICATION found, creating one"

    # Copy the template directory
    cp -r $APP_DIR/template $APP_DIR/$APPLICATION
    
    # Add the new application to the list of imports
    sed -i "/imports = \\[/a \ \ \ \ ./${APPLICATION}" $APP_DIR/default.nix
fi

CONFIG_FILE=$(basename $CONFIG_PATH)

# Copy in the configuration file
cp $CONFIG_PATH $APP_DIR/$APPLICATION/$CONFIG_FILE

CONFIG_PATH="${CONFIG_PATH/#$HOME\//}"

if ! grep -q "$CONFIG_PATH" $APP_DIR/$APPLICATION/default.nix; then
    sed -i "/home.file = {/a \    \"$CONFIG_PATH\".source = .\/$CONFIG_FILE;" $APP_DIR/$APPLICATION/default.nix
else
    echo "Configuration file $CONFIG_PATH already specified in $APPLICATION"
fi