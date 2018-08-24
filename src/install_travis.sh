#!/bin/bash
declare -a info=($(./get_os_info.sh))

if type "travis" > /dev/null 2>&1
then
    :
else
    gem install travis
fi

