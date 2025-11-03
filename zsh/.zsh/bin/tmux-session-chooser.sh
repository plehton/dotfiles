#!/bin/bash

# Get a list of tmux sessions
sessions=$(tmux list-sessions -F "#{session_name}")

# Use fzf to select a session
selected_session=$(echo "$sessions" | fzf --tmux center \
    --reverse \
    --style full \
    --border \
    --padding 1,1 \
    --border-label ' Choose tmux session ' \
    --input-label  '')

# If a session was selected, attach to it
if [ -n "$selected_session" ]; then
    tmux switch-client -t "$selected_session"
fi
