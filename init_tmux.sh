#!/bin/sh

tmux new -s main -n editor -d

tmux send-keys -t editor "cd $1" C-m
tmux send-keys -t editor "vim" C-m

tmux splitw -t editor -h

tmux neww -t main -n debug
#tmux send-keys -t editor "gdb" C-m

tmux splitw -t debug -h -b 
tmux send-keys -t debug "tty > /tmp/source_win" C-m

tmux splitw -t debug -v 
tmux send-keys -t debug "tty > /tmp/mem_win" C-m

tmux select-pane -t 2

tmux send-keys -t debug "gdb" C-m
tmux send-keys -t debug C-m

tmux send-keys -t debug "dashboard source -output $(</tmp/source_win)" C-m
tmux send-keys -t debug "dashboard memory -output $(</tmp/mem_win)" C-m
tmux send-keys -t debug "cd $1" C-m
tmux attach -t main

