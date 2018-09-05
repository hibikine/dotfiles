#!/bin/bash
declare -a info=($(./get_os_info.sh))

if type "template" > /dev/null 2>&1
then
    :
else
    case ${info[0]} in
        ubuntu | debian)
            sudo -E apt install -y template
            ;;
        osx)
            brew install template
            ;;
    esac
fi
