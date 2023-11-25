#!/bin/bash
declare -a info=($(./get_os_info.sh))

if type "direnv" > /dev/null 2>&1
then
    :
else
    case ${info[0]} in
        ubuntu | debian)
            sudo -E apt install -y direnv
            ;;
        osx)
            brew install direnv
            ;;
    esac
fi
