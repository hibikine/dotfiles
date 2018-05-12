#!/bin/bash
# install tig
if [[ $(installed_command tig) -eq 0 ]]; then
    case ${info[0]} in
        osx)
            brew install tig
            ;;
        *)
            cd ~/ && \
                mkdir -p ~/src && \
                cd src && \
                git clone https://github.com/jonas/tig.git && \
                cd tig && \
                make configure && \
                ./configure && \
                make prefix=/usr/local && \
                sudo make install prefix=/usr/local && \
                sudo make install-doc
            ;;
    esac
    cd $script_dir
fi