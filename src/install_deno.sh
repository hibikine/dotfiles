#!/bin/bash
declare -a info=($(./get_os_info.sh))

if type "deno" > /dev/null 2>&1
then
    :
else
    case ${info[0]} in
        ubuntu | debian)
            sudo -E apt update && \
                sudo -E apt install -y unzip && \
                curl -fsSL https://deno.land/x/install/install.sh | sh && \
                mkdir -p ~/.zsh && \
                deno completions zsh > ~/.zsh/_deno
            ;;
        osx)
            brew install deno && \
                mkdir -p ~/.zsh && \
                deno completions zsh > ~/.zsh/_deno
            ;;
    esac
fi

