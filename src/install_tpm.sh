#!/bin/bash

if [ -e "$HOME/.tmux/plugins/tpm" ]; then
    :
else
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

