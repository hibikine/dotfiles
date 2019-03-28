#!/bin/bash
declare -a info=($(./get_os_info.sh))

if type "go" > /dev/null 2>&1
then
    :
else
    case ${info[0]} in
        ubuntu | debian)
            declare -a url=($(wget -qO- https://golang.org/dl/ | grep -oP 'https:\/\/dl\.google\.com\/go\/go([0-9\.]+)\.linux-amd64\.tar\.gz' | head -n 1 ))
            declare -a latest=($(echo $url | grep -oP 'go[0-9\.]+' | grep -oP '[0-9\.]+' | head -c -2))
            curl -sL $url | sudo -E tar -C /usr/local -xzf -
            ;;
        osx)
            brew install go
            ;;
    esac
fi
