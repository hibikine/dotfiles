#!/bin/bash
# declare OS
declare -a info=($(./src/get_os_info.sh))
script_dir=$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)

# install checker
function installed_command() {
    which $1 > /dev/null 2>&1
}

function show_section() {
    echo "\n$1\n"
}

# update packages
echo "Update packages and install"
case ${info[0]} in
    ubuntu)
        # Set japan repository
        if [[ $IS_CI != 'true']]; then
            sudo sed -i.bak -e "s%http://[^ ]\+%http://ftp.riken.go.jp/Linux/ubuntu/%g" /etc/apt/sources.list
            sudo -E apt-get update
        fi
        ;;
    debian)
        # Set japan repository
        if [[ $IS_CI != 'true']]; then
            sudo -E deb http://ftp.jp.debian.org/debian/ squeeze main contrib non-free
            sudo -E apt-get update
        fi
        ;;
esac

if [[ $1 = 'full' ]]; then
    # Install packages
    case ${info[0]} in
        osx)
            brew tap homebrew/versions
            ;;
        ubuntu | debian)
            # Install packages
            show_section "Update and install packages"
            sudo -E apt-get update && \
                sudo -E apt-get install -y ctags openssl \
                pkg-config silversearcher-ag zsh && \
                sudo apt-get upgrade -y && \
                sudo apt-get autoremove -y
            ;;
    esac
fi

# install vim plugins
if [[ $IS_CI != 'true' ]]; then
    vim "+silent PluginInstall" "+qall"
fi

# create config file
touch ~/.dotzconfig
