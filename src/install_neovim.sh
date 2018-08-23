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
                sudo -E apt-get install -y software-properties-common \
                sudo -E add-apt-repository ppa:neovim-ppa/unstable && \
                sudo -E apt-get update && \
                sudo -E apt-get install -y neovim python-neovim python3-neovim
                sudo -E update-alternatives --install /usr/bin/vi vi /use/bin/nvim 60 \
                sudo -E update-alternatives --config vi \
                sudo -E update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60 \
                sudo -E update-alternatives --config vim \
                sudo -E update-alternatives --instlal /usr/bin/editor editor /usr/bin/nvim 60 \
                sudo -E update-alternatives --config editor
            ;;
        osx)
            brew install neovim
            ;;
    esac
fi