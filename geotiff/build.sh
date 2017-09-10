#!/bin/sh

set -e # Abort on error.

if [ $(uname) == Darwin ]; then
    export CC=clang
    export CXX=clang++
else
    export CC=gcc-4.8
    export CXX=g++-4.8
fi

./configure \
  --prefix=$PREFIX \
  --with-libtiff=$PREFIX \
  --with-proj=$PREFIX \
  --enable-incode-epsg

make -j $CPU_COUNT
make check
make install
make clean