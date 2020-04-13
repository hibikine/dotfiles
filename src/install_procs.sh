#!/bin/bash
declare -a info=($(./get_os_info.sh))

if type "procs" > /dev/null 2>&1
then
    :
else
    case ${info[0]} in
        ubuntu | debian)
            cargo install procs
            ;;
        osx)
            brew install procs
            ;;
    esac
fi
