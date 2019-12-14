#!/bin/bash
declare -a info=($(./get_os_info.sh))

if type "rustup" > /dev/null 2>&1
then
    :
else
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | bash -s -- -y --default-toolchain nightly
fi
