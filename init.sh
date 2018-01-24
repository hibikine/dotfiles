# declare OS
declare -a info=($(./get_os_info))

# update packages
echo "Update packages and install"
case ${info[0]} in
    ubuntu)
        # Set japan repository
        sed -i.bak -e "s%http://[^ ]\+%http://ftp.jaist.ac.jp/pub/Linux/ubuntu/%g" /etc/apt/sources.list
        # Add vim repository
        sudo add-apt-repository ppa:jonathonf/vim
        ;;
    debian)
        # Set japan repository
        deb http://ftp.jp.debian.org/debian/ squeeze main contrib non-free
        ;;
esac

# Install packages
case ${info[0]} in
    ubuntu | debian)
        # Install packages
        add-apt-repository ppa:ondrej/php
        apt-get update && \
            apt-get install build-essential curl git nodejs npm openssl \
            php7.2 php7.2-mbstring php7.2-mysql php7.2-sqlite php7.2-zip php7.2-dom \
            pkg-config python3-taglib sqlite3 vim zsh -y && \
            apt-get upgrade -y && \
            apt-get autoremove -y
        # Upgrade node
        npm cache clean
        npm install n -g
        n latest
        ln -sf /usr/local/bin/node /usr/bin/node
        apt-get purge -y nodejs npm
        # Install yarn
        curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
        echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
        apt-get update && apt-get install yarn -y && apt-get autoremove -y
        # Install composer
        curl -sS https://getcomposer.org/installer | php
        mv composer.phar /usr/local/bin/composer
        chmod +x /usr/local/bin/composer
        ;;
esac

# install prezto
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

