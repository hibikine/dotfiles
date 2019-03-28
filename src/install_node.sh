#!/bin/bash
declare -a info=($(./get_os_info.sh))

if type "template" > /dev/null 2>&1
then
    :
else
    case ${info[0]} in
        ubuntu | debian)
            sudo -E apt update && \
                sudo -E apt install nodejs nodejs-dev node-gyp libssl1.0-dev && \
                sudo -E apt install npm && \
                sudo -E npm cache clean && \
                sudo -E npm i -g n && \
                sudo -E n latest && \
                sudo -E ln -sf /usr/local/bin/node /usr/bin/node && \
                sudo -E apt-get purge -y nodejs npm
            ;;
        osx)
            brew install nodebrew && \
                nodebrew install-binary latest && \
                nodebrew use latest
            ;;
    esac
fi

