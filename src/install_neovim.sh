#!/bin/bash
declare -a info=($(./get_os_info.sh))

if type "nvim" > /dev/null 2>&1
then
    :
else
    case ${info[0]} in
        ubuntu|debian)
            # Add vim repository
            sudo -E apt-get update && \
                sudo -E apt-get install -y software-properties-common && \
                sudo -E add-apt-repository -y ppa:neovim-ppa/unstable && \
                sudo -E apt-get update && \
                sudo -E apt-get install -y neovim
            ;;
        osx)
            brew install neovim
            ;;
    esac
fi