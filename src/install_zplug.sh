#!/bin/bash
if type "zplug" > /dev/null 2>&1
then
    :
else
    curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh| zsh
fi
zplug install
