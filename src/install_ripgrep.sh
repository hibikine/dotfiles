#!/bin/bash
declare -a info=($(./get_os_info.sh))
RIPGREP_DEB_PATH="./ripgrep.deb"

if type "ripgrep" > /dev/null 2>&1
then
    :
else
    case ${info[0]} in
        ubuntu | debian)
            # Snap install
            #sudo -E snap install -y ripgrep --classic

            # Manually Install
            # Before Cleanup
            rm -f $RIPGREP_DEB_PATH
            curl -s https://api.github.com/repos/BurntSushi/ripgrep/releases/latest \
            | grep "browser_download_url.*deb" \
            | cut -d : -f 2,3 \
            | tr -d \" \
            | wget -qi - -O $RIPGREP_DEB_PATH
            # Install
            sudo dpkg -i -GE $RIPGREP_DEB_PATH
            # After Cleanup
            rm -f $RIPGREP_DEB_PATH
            ;;
        osx)
            brew install ripgrep
            ;;
    esac
fi
