#!/bin/bash
declare -a info=($(./get_os_info.sh))

if type "gcloud" > /dev/null 2>&1
then
    :
else
    case ${info[0]} in
        ubuntu | debian | osx)
            curl https://sdk.cloud.google.com | bash - --disable-prompts
            ;;
    esac
fi

