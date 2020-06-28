#!/bin/bash
declare -a info=($(./get_os_info.sh))

if type "nix" > /dev/null 2>&1
then
    :
else
    case ${info[0]} in
        ubuntu | debian)
            curl https://nixos.org/nix/install | sh
            ;;
        osx)
            :
            ;;
    esac
fi
