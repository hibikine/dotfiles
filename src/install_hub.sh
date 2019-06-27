#!/bin/bash
declare -a info=($(./get_os_info.sh))

get_latest_release() {
  curl --silent "https://api.github.com/repos/$1/releases/latest" | # Get latest release from GitHub api
  grep '"tag_name":' |                                            # Get tag line
  sed -E 's/.*"([^"]+)".*/\1/'                                    # Pluck JSON value
}

case ${info[0]} in
    ubuntu | debian)
        mkdir -p /tmp/hub && \
            curl -L "https://github.com/github/hub/releases/download/v2.12.0/hub-linux-amd64-$(get_latest_release "github/hub" | sed 's/v//').tgz" | tar -zx -C /tmp/hub/ --strip-components 1 && \
            sudo -E /tmp/hub/install
        ;;
    osx)
        brew install hub
        ;;
esac

