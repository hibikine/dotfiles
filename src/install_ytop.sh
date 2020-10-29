#!/bin/bash
declare -a info=($(./get_os_info.sh))

if type "ytop" > /dev/null 2>&1
then
    :
else
    case ${info[0]} in
        ubuntu | debian)
            curl -s https://api.github.com/repos/cjbassi/ytop/releases/latest \
                | grep "browser_download_url.*unknown-linux-gnu.tar.gz" \
                | cut -d : -f 2,3 \
                | tr -d \" \
                | wget -O - -qi - \
                | sudo tar zxvf - -C /usr/local/bin
            ;;
        osx)
            brew tap cjbassi/ytop
            brew install ytop
            ;;
    esac
fi
