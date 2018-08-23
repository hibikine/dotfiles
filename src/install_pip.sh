#!/bin/bash
declare -a info=($(./get_os_info.sh))

if type "pip" > /dev/null 2>&1
then
    case ${info[0]} in
        ubuntu | debian)
            curl https://bootstrap.pypa.io/get-pip.py | sudo python -
            ;;
        osx)
            curl https://bootstrap.pypa.io/get-pip.py | sudo python -
            ;;
    esac
fi


