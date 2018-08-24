#!/bin/bash
declare -a info=($(./get_os_info.sh))

case ${info[0]} in
    ubuntu | debian)
        wget https://github.com/knqyf263/pet/releases/download/v0.3.0/pet_0.3.0_linux_amd64.deb
        sudo dpkg -i pet_0.3.0_linux_amd64.deb
        ;;
    osx)
        brew install knqyf263/pet/pet
        ;;
esac

