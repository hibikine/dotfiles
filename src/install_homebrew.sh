#!/bin/bash
declare -a info=($(./get_os_info.sh))

if type "brew" > /dev/null 2>&1
then
    :
else
    case ${info[0]} in
        debian|ubuntu)
            sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
            ;;
        osx)
            /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
            ;;
    esac
fi

