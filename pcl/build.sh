#!/bin/bash
set -e # Abort on error.

## START BUILD
if [ $(uname) == Darwin ]; then
    #export LDFLAGS="-headerpad_max_install_names"
    # OPTS="--enable-rpath"
    # export CXXFLAGS="-stdlib=libc++ $CXXFLAGS"
    export CC=clang
    export CXX=clang++
    export MACOSX_DEPLOYMENT_TARGET="10.9"
    # export CXXFLAGS="${CXXFLAGS} -stdlib=libc++"
    # export LDFLAGS="${LDFLAGS} -headerpad_max_install_names"
else
    #export OPTS="--disable-rpath"
    export CC=gcc-4.8
    export CXX=g++-4.8
fi

# export LDFLAGS="$LDFLAGS -L$PREFIX/lib"
# export CPPFLAGS="$CPPFLAGS -I$PREFIX/include"

mkdir build
cd build

CMAKE_GENERATOR="Unix Makefiles"

if [ "$(uname)" == "Linux" ]; then
  cmake .. -G "$CMAKE_GENERATOR" \
    -DCMAKE_BUILD_TYPE=Release \
    -DBUILD_apps:BOOL=OFF \
    -DBUILD_tools:BOOL=OFF \
    -DBUILD_examples:BOOL=OFF \
    -DBUILD_global_tests:BOOL=OFF \
    -DWITH_OPENGL=FALSE \
    -DCMAKE_DISABLE_FIND_PACKAGE_OpenNI:BOOL=TRUE \
    -DCMAKE_DISABLE_FIND_PACKAGE_Qt4:BOOL=TRUE \
    -DCMAKE_DISABLE_FIND_PACKAGE_VTK:BOOL=TRUE \
    -DBUILD_outofcore:BOOL=AUTO_OFF \
    -DBUILD_people:BOOL=AUTO_OFF \
    -DBUILD_SHARED_LIBS:BOOL=ON \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DBOOST_LIBRARYDIR=$PREFIX/lib \
    -DCMAKE_PREFIX_PATH="${PREFIX}" \
    -DCMAKE_EXE_LINKER_FLAGS=-L"${PREFIX}"/lib \
    -DCMAKE_MODULE_LINKER_FLAGS=-L"${PREFIX}"/lib \
    -DCMAKE_SHARED_LINKER_FLAGS=-L"${PREFIX}"/lib
fi


if [ "$(uname)" == "Darwin" ]; then
  cmake .. -G "$CMAKE_GENERATOR" \
    -DCMAKE_BUILD_TYPE=Release \
    -DBUILD_apps:BOOL=OFF \
    -DBUILD_tools:BOOL=OFF \
    -DBUILD_examples:BOOL=OFF \
    -DBUILD_global_tests:BOOL=OFF \
    -DWITH_OPENGL=FALSE \
    -DCMAKE_DISABLE_FIND_PACKAGE_OpenNI:BOOL=TRUE \
    -DCMAKE_DISABLE_FIND_PACKAGE_Qt4:BOOL=TRUE \
    -DCMAKE_DISABLE_FIND_PACKAGE_VTK:BOOL=TRUE \
    -DBUILD_outofcore:BOOL=AUTO_OFF \
    -DBUILD_people:BOOL=AUTO_OFF \
    -DBUILD_SHARED_LIBS:BOOL=ON \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DBOOST_LIBRARYDIR=$PREFIX/lib \
    -DCMAKE_PREFIX_PATH="${PREFIX}"
fi

make -j $CPU_COUNT
make install
