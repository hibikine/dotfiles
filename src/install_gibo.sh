#!/bin/bash
declare -a info=($(./get_os_info.sh))

case ${info[0]} in
    ubuntu | debian)
        curl -L https://raw.github.com/simonwhitaker/gibo/master/gibo \
            -so ~/bin/gibo && chmod +x ~/bin/gibo && gibo -u
        ;;
    osx)
        brew install gibo
        ;;
esac

