#!/bin/bash

OBSIDIAN_VAULT_PATH="$1"
OBSIDIAN_WORKSPACE_FILE=$OBSIDIAN_VAULT_PATH/.obsidian/workspace.json

ACTIVE_FILE_ID=$(jq -r .active "$OBSIDIAN_WORKSPACE_FILE" | tr -d '"')

if [[ -z $ACTIVE_FILE_ID ]]; then
    echo "No active file found in the Obsidian workspace."
    exit 1
fi

ACTIVE_FILE_SUBPATH=$(jq -r ".main.children[0].children" $OBSIDIAN_WORKSPACE_FILE | \
    jq -r ".[] | select(.id == \"$ACTIVE_FILE_ID\")" | \
    jq -r ".state.state.file" | tr -d '"')

ACTIVE_FILE_PATH=$OBSIDIAN_VAULT_PATH/$ACTIVE_FILE_SUBPATH

if [[ ! -f "$ACTIVE_FILE_PATH" ]]; then
    echo "Active file does not exist: $ACTIVE_FILE_PATH"
    exit 1
fi

echo $ACTIVE_FILE_PATH
