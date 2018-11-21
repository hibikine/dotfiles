#!/bin/bash

# is wsl?
if [ -f /proc/sys/fs/binfmt_misc/WSLInterop ]; then
    if $(git config --global --get credential.helper | grep 'git-credential-wincred.exe' > /dev/null); then
        :
    else
        git config --file ~/.gitconfig.local credential.thelper "/mnt/c/Program\\ Files/Git/mingw64/libexec/git-core/git-credential-wincred.exe"
    fi
fi
