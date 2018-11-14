#!/bin/bash

if type "gvm" > /dev/null 2>&1
then
    :
else
    bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)
fi
