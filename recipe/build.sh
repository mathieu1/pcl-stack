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
    COMP_CC=gcc-4.8
    COMP_CXX=g++-4.8
    export CXXFLAGS="$CXXFLAGS -std=c++11"
fi

export LDFLAGS="$LDFLAGS -L$PREFIX/lib"
export CPPFLAGS="$CPPFLAGS -I$PREFIX/include"
export LD_LIBRARY_PATH=$PREFIX/lib

# `--without-pam` was removed.
# See https://github.com/conda-forge/gdal-feedstock/pull/47 for the discussion.

cmake -G "Unix Makefiles" \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX="${PREFIX}" \
    -DCMAKE_INSTALL_RPATH="${PREFIX}"/lib \
    -DCMAKE_EXE_LINKER_FLAGS=-L"${PREFIX}"/lib \
    -DCMAKE_MODULE_LINKER_FLAGS=-L"${PREFIX}"/lib \
    -DCMAKE_SHARED_LINKER_FLAGS=-L"${PREFIX}"/lib \
    -DBUILD_PLUGIN_PYTHON=ON \
    -DBUILD_PLUGIN_PCL=ON \
    -DBUILD_PLUGIN_PGPOINTCLOUD=OFF \
    -DBUILD_PLUGIN_SQLITE=ON \
    -DENABLE_CTEST=OFF \
    -DWITH_TESTS=OFF \
    -DWITH_APPS=ON

# CircleCI offers two cores.
make -j $CPU_COUNT
make install

cd python
python setup.py build
python setup.py install
