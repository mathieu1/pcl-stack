#!/bin/bash

set -e # Abort on error.

## START BUILD
if [ $(uname) == Darwin ]; then
    #export LDFLAGS="-headerpad_max_install_names"
    OPTS="--disable-rpath"
    export CXXFLAGS="-stdlib=libc++ $CXXFLAGS"
    COMP_CC=clang
    COMP_CXX=clang++
    export MACOSX_DEPLOYMENT_TARGET="10.9"
    export CXXFLAGS="${CXXFLAGS} -stdlib=libc++"
    export LDFLAGS="${LDFLAGS} -headerpad_max_install_names"
else
    OPTS="--disable-rpath"
    COMP_CC=gcc
    COMP_CXX=g++
    export CXXFLAGS="${CXXFLAGS}"
fi

export LDFLAGS="$LDFLAGS -L$PREFIX/lib"
export CPPFLAGS="$CPPFLAGS -I$PREFIX/include"

# `--without-pam` was removed.
# See https://github.com/conda-forge/gdal-feedstock/pull/47 for the discussion.

cmake -G "Unix Makefiles" \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DBUILD_PLUGIN_PYTHON=ON \
    -DBUILD_PLUGIN_PCL=ON \
    -DBUILD_PLUGIN_PGPOINTCLOUD=OFF \
    -DBUILD_PLUGIN_SQLITE=ON \
    -DENABLE_CTEST=OFF \
    -DWITH_TESTS=ON \
    -DWITH_APPS=ON

# CircleCI offers two cores.
make -j $CPU_COUNT
make install

cd python
python setup.py build
python setup.py install
