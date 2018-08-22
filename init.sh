#!/bin/bash
# declare OS
declare -a info=($(./src/get_os_info.sh))
script_dir=$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)

# install checker
function installed_command() {
    which $1 > /dev/null 2>&1
}

function show_section() {
    echo "\n$1\n"
}

# install package manager
case ${info[0]} in
    osx)
        # Install Homebrew
        ./src/install_homebrew.sh
        ;;
esac

# update packages
echo "Update packages and install"
case ${info[0]} in
    ubuntu)
        # Set japan repository
        sudo sed -i.bak -e "s%http://[^ ]\+%http://ftp.riken.go.jp/Linux/ubuntu/%g" /etc/apt/sources.list
        # sudo sed -i.bak -e "s%http://[^ ]\+%http://ftp.jaist.ac.jp/pub/Linux/ubuntu/%g" /etc/apt/sources.list

        # Add vim repository
        sudo -E apt-get update && \
            sudo -E apt-get install -y software-properties-common \
            sudo -E add-apt-repository ppa:neovim-ppa/unstable
        sudo -E apt-get update
        ;;
    debian)
        # Set japan repository
        sudo -E deb http://ftp.jp.debian.org/debian/ squeeze main contrib non-free
        ;;
esac

case ${info[0]} in
    osx)
        brew install git
        brew install neovim
        ;;
    debian)
        sudo -E apt-get install -y curl git
        sudo -E apt-get install -y neovim python-neovim python3-neovim
        ;;
    ubuntu)
        sudo -E apt-get install -y curl git
        sudo -E apt-get install -y python-dev python-pip python3-dev \
            sudo -E apt-get install -y python3-setuptools \
            sudo -E easy_install3 pip \
            sudo -E apt-get install -y neovim \
            sudo -E update-alternatives --install /usr/bin/vi vi /use/bin/nvim 60 \
            sudo -E update-alternatives --config vi \
            sudo -E update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60 \
            sudo -E update-alternatives --config vim \
            sudo -E update-alternatives --instlal /usr/bin/editor editor /usr/bin/nvim 60 \
            sudo -E update-alternatives --config editor
        ;;
esac

if [[ $1 = 'full' ]]; then
    # Install packages
    case ${info[0]} in
        osx)
            # Add Repos
            show_section "Add Repos"
            brew tap homebrew/dupes
            brew tap homebrew/versions
            brew tap homebrew/homebrew-php
            brew update
            # Install zsh
            brew install zsh
            # Install Node
            show_section "Install Node.js"
            brew install nodebrew && \
                nodebrew install-binary latest && \
                nodebrew use latest
            # Install php
            show_section "Install PHP"
            brew install php71 && \
                brew install homebrew/php/composer
            ;;
        ubuntu | debian)
            # Install packages
            show_section "Add Repos"
            sudo -E add-apt-repository -y ppa:ondrej/php
            show_section "Update and install packages"
            sudo -E apt-get update && \
                sudo -E apt-get install ctags nodejs npm openssl \
                pkg-config silversearcher-ag zsh -y && \
                sudo apt-get upgrade -y && \
                sudo apt-get autoremove -y
            # Upgrade node
            show_section "Upgrade Node.js"
            sudo npm cache clean && \
                sudo -E npm install n -g && \
                sudo -E n latest && \
                sudo -E ln -sf /usr/local/bin/node /usr/bin/node && \
                apt-get purge -y nodejs npm && \

            # Install yarn
            show_section "Install Yarn"
            if type "yarn" > /dev/null 2>&1
            then
                ./src/install_yarn.sh
            fi

            # Install composer

            show_section "Install Composer"
            curl -sS https://getcomposer.org/installer | php && \
                sudo -E mv composer.phar /usr/local/bin/composer && \
                sudo chmod +x /usr/local/bin/composer

            # Install gcloud
            export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)"
            echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
            curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo -E apt-key add -
            sudo -E apt-get update && sudo -E apt-get install google-cloud-sdk
            ;;
    esac
fi

# install zplug
if type "zplug" > /dev/null 2>&1
then
    curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh| zsh
fi
zplug install

if [[ $1 = 'full' ]]; then
    case ${info[0]} in
        ubuntu | debian)
            # install cz-cli
            ./src/install_cz_cli_deb.sh
            ;;
    esac
fi

if [[ $1 = 'full' ]]; then
    case ${info[0]} in
        ubuntu | debian)
            # install rbenv
            git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
            git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
            echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.dotzconfig
            echo 'eval "$(rbenv init -)"' >> ~/.dotzconfig
            ;;
    esac
fi

# install vundle
if [[ $IS_CI != 'true' ]]; then
    vim "+silent PluginInstall" "+qall"
fi

# create config file
touch .dotzconfig

