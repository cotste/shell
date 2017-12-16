#!/bin/sh

tmux new -s main -n terminal -d

tmux neww -t main -n editor

tmux send-keys -t editor "cd $1" C-m
tmux send-keys -t editor "vim" C-m

tmux neww -t main -n debug

tmux splitw -t debug -h -b 
tmux send-keys -t debug "tty > /tmp/source_win" C-m

tmux splitw -t debug -v 
tmux send-keys -t debug "tty > /tmp/asm_win" C-m

tmux select-pane -t 2

tmux send-keys -t debug "gdb" C-m
tmux send-keys -t debug C-m

tmux send-keys -t debug "dashboard source -output $(</tmp/source_win)" C-m
tmux send-keys -t debug "dashboard assembly -output $(</tmp/asm_win)" C-m
tmux send-keys -t debug "cd $1" C-m

tmux select-window -t terminal

tmux attach -t main

