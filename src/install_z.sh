#!/bin/bash
declare -a info=($(./get_os_info.sh))

if type "z" > /dev/null 2>&1
then
    :
else
    case ${info[0]} in
        ubuntu | debian)
	    curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
            ;;
        osx)
            brew install zoxide
            ;;
    esac
fi
