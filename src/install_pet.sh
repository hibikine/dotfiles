#!/bin/bash
declare -a info=($(./get_os_info.sh))
declare -a pet_version=($(./get_latest_release.sh "knqyf263/pet"))
declare -a pet_version_without_v=($(echo $pet_version | sed -e 's/v//'))
PET_DEB_PATH="./pet.deb"

case ${info[0]} in
    ubuntu | debian)
        rm -f $PET_DEB_PATH
        curl -s https://api.github.com/repos/knqyf263/pet/releases/latest \
        | grep "browser_download_url.*amd64.deb" \
        | cut -d : -f 2,3 \
        | tr -d \" \
        | wget -qi - -O $PET_DEB_PATH
        # Install
        sudo dpkg -i -GE $PET_DEB_PATH
        # After Cleanup
        rm -f $PET_DEB_PATH;;
    osx)
        brew install knqyf263/pet/pet
        ;;
esac

