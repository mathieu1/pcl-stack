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
    export WITH_SQLITE="NO"
#    export CXXFLAGS="${CXXFLAGS} -stdlib=libc++"
#    export LDFLAGS="${LDFLAGS} -headerpad_max_install_names"
    #export DYLD_FALLBACK_LIBRARY_PATH=$PREFIX/lib
else
    OPTS="--disable-rpath"
    export CC=gcc-4.8
    export CXX=g++-4.8
    export CXXFLAGS="$CXXFLAGS -std=c++11"
    export LD_LIBRARY_PATH=$PREFIX/lib
    export WITH_SQLITE="YES"
fi

#export LDFLAGS="$LDFLAGS -L$PREFIX/lib"

cmake -G "Unix Makefiles" \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DCMAKE_MACOSX_RPATH=ON \
    -DCMAKE_INSTALL_RPATH=$PREFIX/lib \
    -DCMAKE_EXE_LINKER_FLAGS=-L$PREFIX/lib \
    -DCMAKE_MODULE_LINKER_FLAGS=-L$PREFIX/lib \
    -DCMAKE_SHARED_LINKER_FLAGS=-L$PREFIX/lib \
    -DBUILD_PLUGIN_CPD=OFF \
    -DBUILD_PLUGIN_GREYHOUND=ON \
    -DBUILD_PLUGIN_ICEBRIDGE=ON \
    -DBUILD_PLUGIN_PYTHON=ON \
    -DBUILD_PLUGIN_PCL=ON \
    -DBUILD_PLUGIN_PGPOINTCLOUD=ON \
    -DBUILD_PLUGIN_SQLITE=$WITH_SQLITE \
    -DENABLE_CTEST=OFF \
    -DWITH_TESTS=OFF \
    -DWITH_LAZPERF=ON \
    -DWITH_COMPLETION=ON \

make -j $CPU_COUNT
make install

cd python
python setup.py build
python setup.py install
