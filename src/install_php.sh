#!/bin/bash
declare -a info=($(./get_os_info.sh))

if type "php" > /dev/null 2>&1
then
    :
else
    case ${info[0]} in
        ubuntu | debian)
            sudo -E add-apt-repository -y ppa:ondrej/php && \
                sudo -E apt install -y php7.1
            ;;
        osx)
            brew tap homebrew/homebrew-php && \
                brew update && \
                brew install php71
            ;;
    esac
fi



