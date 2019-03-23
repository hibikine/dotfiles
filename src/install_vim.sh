#!/bin/bash
declare -a info=($(./get_os_info.sh))

if type "template" > /dev/null 2>&1
then
    :
else
    case ${info[0]} in
        ubuntu | debian)
            sudo add-apt-repository ppa:jonathonf/vim -y
            ;;
        osx)
            brew install vim
            ;;
    esac
fi
