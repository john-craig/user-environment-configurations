#!/bin/zsh

LONG_RUNNING=5

send_notification() {
    API_TOKEN_PATH=/sec/gotify/$(hostname)/$(whoami)/api-token.txt
    FALLBACK=0

    if [[ -f $API_TOKEN_PATH ]]; then
        API_TOKEN=$(cat $API_TOKEN_PATH)

        curl -s -S --data '{"message": "'"Command Completed"'", "title": "'"$1"'", "priority":'"5"', "extras": {"client::display": {"contentType": "text/markdown"}}}' -H 'Content-Type: application/json' "https://gotify.chiliahedron.wtf/message?token=$API_TOKEN" 2>&1 > /dev/null

        if [[ $? -ne 0 ]]; then
            FALLBACK=1
        fi
    else
        FALLBACK=1
    fi

    # For now set this always
    FALLBACK=1

    if [[ $FALLBACK -eq 1 ]]; then
        hyprctl notify 1 5000 0 "Command \`$1\` completed" 2>&1 > /dev/null
    fi
}

start_notify_timer() {
    CMD_START_TIME=$(date +%s)
    CMD_STRING="$1"
}

end_notify_timer() {
    CMD_END_TIME=$(date +%s)
    CMD_RUN_TIME=$((CMD_END_TIME-CMD_START_TIME))

    if [[ $CMD_RUN_TIME > $LONG_RUNNING ]]; then
        send_notification "$CMD_STRING"
    fi

    unset CMD_START_TIME
    unset CMD_END_TIME
    unset CMD_RUN_TIME
    unset CMD_STRING
}

preexec_functions=(start_notify_timer)
precmd_functions=(end_notify_timer)