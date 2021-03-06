#!/usr/bin/env bash

# Configure a TMUX session named speech and prepare to start the training process.
# Note: Script MUST be run from the repositories root folder.

# First, kill all running temp_log.sh scripts.
pgrep -f "bash ./log_temp.sh" | xargs -n 1 bash -c 'kill "$0"'

tmux new-session -d -s speech '$SHELL'
tmux set -g window-status-current-bg blue
tmux select-pane -t 0
tmux send-keys './log_temp.sh &' C-m
tmux send-keys 'tail -f temp.log' C-m
tmux split-window -h '$SHELL'
tmux select-pane -t 1
tmux send-keys 'tensorboard --logdir ../speech_checkpoints' C-m
tmux split-window -v -p 80 '$SHELL'
tmux select-pane -t 2
tmux send-keys 'htop' C-m
tmux select-pane -t 0
tmux split-window -v -p 80 '$SHELL'
tmux select-pane -t 1

tmux attach-session -d -t speech
