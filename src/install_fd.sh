#!/bin/bash
declare -a info=($(./get_os_info.sh))

if type "fd" > /dev/null 2>&1
then
    :
else
    case ${info[0]} in
        ubuntu | debian)
            curl -s https://api.github.com/repos/sharkdp/fd/releases/latest \
                | grep "browser_download_url.*fd_.*amd64\.deb" \
                | cut -d : -f 2,3 \
                | tr -d \" \
                | wget -O fd.deb -qi -
            sudo dpkg -i fd.deb
            rm -f fd.deb
            ;;
        osx)
            brew install fd
            ;;
    esac
fi
