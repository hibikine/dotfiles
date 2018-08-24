#!/bin/bash
declare -a info=($(./get_os_info.sh))

case ${info[0]} in
    ubuntu|debian|osx)
        brew install knqyf263/pet/pet
        ;;
esac

