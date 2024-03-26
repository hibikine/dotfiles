#!/bin/bash
declare -a info=($(./get_os_info.sh))

case ${info[0]} in
    ubuntu|debian)
        sudo -E npm i -g git-cz
        ;;
    osx)
        npm i -g git-cz
        ;;
esac


