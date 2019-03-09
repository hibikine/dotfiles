#!/bin/bash
declare -a info=($(./get_os_info.sh))

case ${info[0]} in
    ubuntu | debian)
        if [[ $IS_CI != 'true' ]]; then
            go get github.com/github/hub; \
                cd "$GOPATH"/src/github.com/github/hub; \
                make install prefix=/usr/local
        fi
        ;;
    osx)
        brew install hub
        ;;
esac

