#!/bin/bash
declare -a info=($(./get_os_info.sh))

#if type "imwheel" > /dev/null 2>&1
#then
#    :
#else
    case ${info[0]} in
        ubuntu | debian)
            sudo -E apt install -y imwheel
            sudo ln -s ~/dotfiles/bin/mousewheel.sh /usr/local/bin/mousewheel.sh
            sudo ln -sf ~/dotfiles/services/mousewheel.service /etc/systemd/system/
            sudo systemctl enable mousewheel.service
            sudo systemctl start mousewheel.service
            ;;
    esac
#fi
