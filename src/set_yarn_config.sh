#!/bin/bash

yarn config set init-license MIT -g
yarn config set init-version 0.1.0 -g
yarn config set emoji true -g
yarn config set network-timeout 100000 -g
yarn config set yarn-offline-mirror "$HOME/.npm-packages-offline-cache" -g
yarn config set yarn-offline-mirror-pruning true -g

