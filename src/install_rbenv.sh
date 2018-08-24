#!/bin/bash
declare -a info=($(./get_os_info.sh))

if type "rbenv" > /dev/null 2>&1
then
    :
else
    case ${info[0]} in
        ubuntu | debian)
            # install rbenv
            git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
            git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
            echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.dotzconfig
            echo 'eval "$(rbenv init -)"' >> ~/.dotzconfig
            ;;
        osx)
            brew install rbenv
            ;;
    esac
fi



