#!/bin/bash
declare -a info=($(./get_os_info.sh))

if type "template" > /dev/null 2>&1
then
    :
else
    case ${info[0]} in
        ubuntu | debian)
            curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add - && \
                echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list && \
                sudo apt-get update && \
                sudo apt-get install --no-install-recommends yarn -y
            ;;
        osx)
            brew install yarn
            ;;
    esac
fi

