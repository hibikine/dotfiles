#!/bin/bash

if type "yvm help" > /dev/null 2>&1
then
    :
else
    curl -fsSL https://raw.githubusercontent.com/tophat/yvm/master/scripts/install.sh | sudo bash
fi
