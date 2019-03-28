#!/bin/bash
declare -a info=($(./get_os_info.sh))
declare -a pet_version=($(./get_latest_release.sh "knqyf263/pet"))
declare -a pet_version_without_v=($(echo $pet_version | sed -e 's/v//'))

case ${info[0]} in
    ubuntu | debian)
        case ${info[1]} in
            i686)
                curl -OL "https://github.com/knqyf263/pet/releases/download/${pet_version}/pet_${pet_version_without_v}_linux_386.deb" && sudo -E dpkg --install "pet_${pet_version_without_v}_linux_386.deb"
                ;;
            x86_64)
                curl -OL "https://github.com/knqyf263/pet/releases/download/${pet_version}/pet_${pet_version_without_v}_linux_amd64.deb" # && sudo -E dpkg --install "pet_${pet_version_without_v}_linux_amd64.deb"
                ;;
        esac
        ;;
    osx)
        brew install knqyf263/pet/pet
        ;;
esac

