#!/bin/bash

set -e # Abort on error.

export CC=gcc-4.8
export CXX=g++-4.8

./configure --prefix=$PREFIX
make -j $CPU_COUNT
make install
