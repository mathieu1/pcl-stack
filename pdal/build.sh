#!/bin/bash

set -e # Abort on error.

## START BUILD
if [ $(uname) == Darwin ]; then
    #export LDFLAGS="-headerpad_max_install_names"
#    OPTS="--disable-rpath"
#    export CXXFLAGS="-stdlib=libc++ $CXXFLAGS"
    COMP_CC=clang
    COMP_CXX=clang++
    export MACOSX_DEPLOYMENT_TARGET="10.9"
#    export CXXFLAGS="${CXXFLAGS} -stdlib=libc++"
#    export LDFLAGS="${LDFLAGS} -headerpad_max_install_names"
    #export DYLD_FALLBACK_LIBRARY_PATH=$PREFIX/lib
else
    OPTS="--disable-rpath"
    export CC=gcc-4.8
    export CXX=g++-4.8
    export CXXFLAGS="$CXXFLAGS -std=c++11"
    export LD_LIBRARY_PATH=$PREFIX/lib
fi

python setup.py build
python setup.py install
