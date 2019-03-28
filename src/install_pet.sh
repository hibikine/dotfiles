#!/bin/bash
declare -a info=($(./get_os_info.sh))
declare -a pet_version=($(./get_os_info.sh "knqyf263/pet"))
declare -a pet_version_without_v=($(echo $pet_version | sed -e 's/v//'))

case ${info[0]} in
    ubuntu | debian)
        case ${info[1]} in
            i686)
                curl -sL0 "https://github.com/knqyf263/pet/releases/download/pet_version/pet_$($pet_version_without_v)_linux_386.deb" | dpkg --install -
                ;;
            x86_64)
                curl -sL0 "https://github.com/knqyf263/pet/releases/download/v0.3.4/pet_$($pet_version_without_v)_linux_amd64.deb" | dpkg --install -
                ;;
        esac
        ;;
    osx)
        brew install knqyf263/pet/pet
        ;;
esac

