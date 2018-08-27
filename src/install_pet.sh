#!/bin/bash
declare -a info=($(./get_os_info.sh))

case ${info[0]} in
    ubuntu | debian)
        mkdir -p $GOPATH/src/knqyf263
        git clone https://github.com/knqyf263/pet $GOPATH/src/knqyf263/pet
        cd $GOPATH/src/knqyf263/pet
        make install
        ;;
    osx)
        brew install knqyf263/pet/pet
        ;;
esac

