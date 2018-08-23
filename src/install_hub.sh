#!/bin/bash
declare -a info=($(./get_os_info.sh))

case ${info[0]} in
    ubuntu | debian)
        go get github.com/github/hub
        cd "$GOPATH"/src/github.com/github/hub
        make install prefix=/usr/local
        ;;
    osx)
        brew install hub
        ;;
esac

