#!/bin/bash
declare -a info=($(./get_os_info.sh))

if type "exa" > /dev/null 2>&1
then
    :
else
    case ${info[0]} in
        ubuntu | debian)
            cargo install exa
            ;;
        osx)
            brew install exa
            ;;
    esac
fi
