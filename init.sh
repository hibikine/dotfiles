#!/bin/bash
# declare OS
declare -a info=($(./get_os_info.sh))
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
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
        ;;
esac

# update packages
echo "Update packages and install"
case ${info[0]} in
    ubuntu)
        # Set japan repository
        sudo sed -i.bak -e "s%http://[^ ]\+%http://ftp.jaist.ac.jp/pub/Linux/ubuntu/%g" /etc/apt/sources.list
        # Add vim repository
        sudo apt-get update && \
            sudo apt-get install -y software-properties-common
        sudo add-apt-repository -y ppa:neovim-ppa/stable \
        sudo apt-get update
        ;;
    debian)
        # Set japan repository
        sudo deb http://ftp.jp.debian.org/debian/ squeeze main contrib non-free
        ;;
esac

case ${info[0]} in
    osx)
        brew install git
        brew install neovim
        ;;
    debian)
        sudo apt-get install -y curl git
        sudo apt-get install -y neovim python-neovim python3-neovim
        ;;
    ubuntu)
        sudo apt-get install -y curl git
        sudo apt-get install -y python-dev python-pip python3-dev \
            sudo apt-get install -y python3-setuptools \
            sudo easy_install3 pip \
            sudo apt-get install -y neovim \
            sudo update-alternatives --install /usr/bin/vi vi /use/bin/nvim 60 \
            sudo update-alternatives --config vi \
            sudo update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60 \
            sudo update-alternatives --config vim \
            sudo update-alternatives --instlal /usr/bin/editor editor /usr/bin/nvim 60 \
            sudo update-alternatives --config editor
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
            sudo add-apt-repository -y ppa:ondrej/php
            show_section "Update and install packages"
            sudo apt-get update && \
                sudo apt-get install nodejs npm openssl \
                pkg-config silversearcher-ag -y && \
                sudo apt-get upgrade -y && \
                sudo apt-get autoremove -y
            # Upgrade node
            show_section "Upgrade Node.js"
            sudo npm cache clean && \
                sudo npm install n -g && \
                sudo n latest && \
                sudo ln -sf /usr/local/bin/node /usr/bin/node && \
                apt-get purge -y nodejs npm && \
            # Install yarn
            show_section "Install Yarn"
            curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add - && \
                echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list && \
                sudo apt-get update && \
                sudo apt-get install yarn -y && \
                sudo apt-get autoremove -y
            # Install composer
            
            show_section "Install Composer"
            curl -sS https://getcomposer.org/installer | php && \
                sudo mv composer.phar /usr/local/bin/composer && \
                sudo chmod +x /usr/local/bin/composer
            # install z
            show_section "Install z"
            sudo wget -P /usr/local/bin/ https://raw.githubusercontent.com/rupa/z/master/z.sh && \
                sudo chmod 755 /usr/local/bin/z.sh
            # Install gcloud
            export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)"
            echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
            curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
            sudo apt-get update && sudo apt-get install google-cloud-sdk
            ;;
    esac
fi

# install prezto
if [ ! -e ${ZDOTDIR:-$HOME}/.zprezto ]; then
    git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto" && \
        "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

if [ $1 = 'full' ]; then
    # install cz-cli
    yarn global add commitizen
fi

# install tig
if [[ $(installed_command tig) -eq 0 ]]; then
    case ${info[0]} in
        osx)
            brew install tig
            ;;
        *)
            cd ~/ && \
                mkdir -p ~/src && \
                cd src && \
                git clone https://github.com/jonas/tig.git && \
                cd tig && \
                make configure && \
                ./configure && \
                make prefix=/usr/local && \
                sudo make install prefix=/usr/local && \
                sudo make install-doc
            ;;
    esac
    cd $script_dir
fi

# wip
if [[ $(installed_comand z) -eq 0 ]]; then
fi

# get php document
wget -O - 'http://jp2.php.net/distributions/manual/php_manual_ja.tar.gz' |
    tar zxvf - -C $HOME/.vim/vim-ref

