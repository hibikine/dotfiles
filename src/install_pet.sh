#!/bin/bash
declare -a info=($(./get_os_info.sh))
declare -a pet_version=($(./get_latest_release.sh "knqyf263/pet"))
declare -a pet_version_without_v=($(echo $pet_version | sed -e 's/v//'))

case ${info[0]} in
    ubuntu | debian)
        sudo -E apt install pet
        ;;
    osx)
        brew install knqyf263/pet/pet
        ;;
esac

