#!/bin/bash
VSCODIUM_CONFIG_PATH="$HOME/.config/VSCodium"
VSCODIUM_WORKSPACE_PATH="$VSCODIUM_CONFIG_PATH/User/workspaceStorage"

# Check if the VSCodium workspace storage directory exists
if [[ ! -d $VSCODIUM_WORKSPACE_PATH ]]; then
    echo "VSCodium workspace storage directory does not exist: $VSCODIUM_WORKSPACE_PATH"
    exit 1
fi

# Find the most recently modified subdirectory in the workspace storage directory
LATEST_WORKSPACE_DIR=$(find "$VSCODIUM_WORKSPACE_PATH" -mindepth 1 -maxdepth 1 \
    -type d -exec stat --format '%Y %n' \
    {} + | sort -n | tail -1 | cut -d' ' -f2-)

if [[ -z $LATEST_WORKSPACE_DIR ]]; then
    echo "No VSCodium workspace found."
    exit 1
fi

LATEST_WORKSPACE_FILE=$LATEST_WORKSPACE_DIR/workspace.json

if [[ ! -f $LATEST_WORKSPACE_FILE ]]; then
    echo "No workspace file found in the latest workspace directory: $LATEST_WORKSPACE_DIR"
    exit 1
fi

# Use jq to extract the workspace folder
WORKSPACE_FOLDER=$(jq -r '.folder' "$LATEST_WORKSPACE_FILE" | sed 's/^file:\/\///')

if [[ -z $WORKSPACE_FOLDER ]]; then
    echo "No workspace folder found in the latest workspace file."
    exit 1
fi

# Print the workspace folder
echo $WORKSPACE_FOLDER