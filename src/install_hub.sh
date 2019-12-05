#!/bin/bash
declare -a info=($(./get_os_info.sh))

case ${info[0]} in
    debian)
        sudo -E apt install hub
        ;;
    ubuntu)
        sudo -E snap install hub --classic
        ;;
    osx)
        brew install hub
        ;;
esac

