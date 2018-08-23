#!/bin/bash
declare -a info=($(./get_os_info.sh))

if type "zplug" > /dev/null 2>&1
then
    case ${info[0]} in
        ubuntu | debian)
            sudo apt install -y template
            ;;
        osx)
            brew install template
            ;;
    esac
fi


