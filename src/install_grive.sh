#!/bin/bash

GRIVE2_BUILD_PARENT_DIR=$HOME/src
mkdir $GRIVE2_BUILD_PARENT_DIR && \
    cd $GRIVE2_BUILD_PARENT_DIR && \
    git clone https://github.com/vitalif/grive2 --depth=1 && \
    cd grive2 && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make -j4 && \
    sudo -E make install

