#!/bin/bash
declare -a info=($(./get_os_info.sh))

if type "peek" > /dev/null 2>&1
then
    :
else
    case ${info[0]} in
        ubuntu)
            sudo -E add-apt-repository -y ppa:peek-developers/stable && \
                sudo -E apt update && sudo -E apt install -y peek
            ;;
    esac
fi
