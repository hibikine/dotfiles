#!/bin/bash
declare -a info=($(./get_os_info.sh))

if type "template" > /dev/null 2>&1
then
    :
else
    case ${info[0]} in
        ubuntu | debian)
            curl -s https://api.github.com/repos/sharkdp/bat/releases/latest \
                | grep "browser_download_url.*bat_.*amd64\.deb" \
                | cut -d : -f 2,3 \
                | tr -d \" \
                | wget -O bat.deb -qi -
            sudo dpkg -i bat.deb
            rm -f bat.deb
            ;;
        osx)
            brew install bat
            ;;
    esac
fi
