#!/bin/bash

set -e # Abort on error.

if [ $(uname) == Darwin ]; then
    export CC=clang
    export CXX=clang++
    export MACOSX_DEPLOYMENT_TARGET="10.9"
else
    export CC=gcc-4.8
    export CXX=g++-4.8
fi

cmake . -DCMAKE_INSTALL_PREFIX=$PREFIX
make -j $CPU_COUNT
make install
