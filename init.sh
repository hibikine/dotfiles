# declare OS
declare -a info=($(./get_os_info.sh))

# update packages
echo "Update packages and install"
case ${info[0]} in
    ubuntu)
        # Set japan repository
        sudo sed -i.bak -e "s%http://[^ ]\+%http://ftp.jaist.ac.jp/pub/Linux/ubuntu/%g" /etc/apt/sources.list
        # Add vim repository
        sudo add-apt-repository ppa:jonathonf/vim -y
        ;;
    debian)
        # Set japan repository
        sudo deb http://ftp.jp.debian.org/debian/ squeeze main contrib non-free
        ;;
esac

# Install packages
case ${info[0]} in
    ubuntu | debian)
        # Install packages
        sudo dd-apt-repository ppa:ondrej/php
        sudo apt-get update && \
            sudo apt-get install build-essential curl git nodejs npm openssl \
            php7.1 php7.1-mbstring php7.1-mysql php7.1-sqlite3 php7.1-zip php7.1-xml \
            pkg-config python3-taglib sqlite3 vim zsh -y && \
            sudo apt-get upgrade -y && \
            sudo apt-get autoremove -y
        # Upgrade node
        sudo npm cache clean
        sudo npm install n -g
        sudo n latest
        sudo ln -sf /usr/local/bin/node /usr/bin/node
        apt-get purge -y nodejs npm
        # Install yarn
        curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
        echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
        sudo apt-get update && sudo apt-get install yarn -y && sudo apt-get autoremove -y
        # Install composer
        curl -sS https://getcomposer.org/installer | php
        sudo mv composer.phar /usr/local/bin/composer
        sudo chmod +x /usr/local/bin/composer
        ;;
esac

# install prezto
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto" && \
    "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"

# get php document
wget -O - 'http://jp2.php.net/distributions/manual/php_manual_ja.tar.gz' |
    tar zxvf - -C $HOME/.vim/vim-ref

