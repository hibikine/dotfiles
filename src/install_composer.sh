#!/bin/bash
declare -a info=($(./get_os_info.sh))

if type "composer" > /dev/null 2>&1
then
    :
else
    case ${info[0]} in
        ubuntu | debian)
            curl -sS https://getcomposer.org/installer | php && \
                sudo -E mv composer.phar /usr/local/bin/composer && \
                sudo chmod +x /usr/local/bin/composer
            ;;
        osx)
            brew install homebrew/php/composer
            ;;
    esac
fi



