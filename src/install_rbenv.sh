#!/bin/bash
declare -a info=($(./get_os_info.sh))

if type "rbenv" > /dev/null 2>&1
then
    :
else
    case ${info[0]} in
        ubuntu | debian)
            curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-installer | bash
            ;;
        osx)
            brew install rbenv
            ;;
    esac
fi
