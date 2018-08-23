#!/bin/bash
declare -a info=($(./get_os_info.sh))

if type "zplug" > /dev/null 2>&1
then
    :
else
    case ${info[0]} in
        ubuntu | debian)
            sudo -E apt install -y python python3 python-dev python3-dev python3-setuptools
            ;;
        osx)
            brew install python python3
            ;;
    esac
fi
