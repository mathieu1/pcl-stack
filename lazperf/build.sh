#!/bin/bash

set -e # Abort on error.

cmake -G "Unix Makefiles" \
    -DCMAKE_C_COMPILER=gcc-4.8 \
    -DCMAKE_CXX_COMPILER=g++-4.8 \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX="${PREFIX}" \
    -DCMAKE_INSTALL_RPATH="${PREFIX}"/lib \
    -DCMAKE_EXE_LINKER_FLAGS=-L"${PREFIX}"/lib \
    -DCMAKE_MODULE_LINKER_FLAGS=-L"${PREFIX}"/lib \
    -DCMAKE_SHARED_LINKER_FLAGS=-L"${PREFIX}"/lib

# CircleCI offers two cores.
make -j $CPU_COUNT
make install

export CC=gcc-4.8
export CXX=g++-4.8

cd python
python setup.py install
