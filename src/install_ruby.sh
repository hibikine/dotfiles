#!/bin/bash
declare -a info=($(./get_os_info.sh))

if type "ruby" > /dev/null 2>&1
then
    :
else
    rbenv install 2.5.1
fi
