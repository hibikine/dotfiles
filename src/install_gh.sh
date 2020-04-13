#!/bin/bash
declare -a info=($(./get_os_info.sh))

case ${info[0]} in
    ubuntu|debian)
        curl -s https://api.github.com/repos/cli/cli/releases/latest \
            | grep "browser_download_url.*amd64.deb" \
            | cut -d : -f 2,3 \
            | tr -d \" \
            | wget -O gh.deb -qi -
        sudo dpkg -i gh.deb
        rm gh.deb
        ;;
    osx)
        brew install gh
        ;;
esac

