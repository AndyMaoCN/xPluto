#!/bin/bash

CMAKE='cmake'
BUILD_DIR='linux_build'
DEP_ROOT=`pwd`

cd zlib*
ZLIB_PATH=`pwd`
echo $ZLIB_PATH
cd ..

if [ ! -d $BUILD_DIR ]; then
    mkdir $BUILD_DIR
fi
cd $BUILD_DIR

$CMAKE $ZLIB_PATH -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$DEP_ROOT/install_linux/zlib
make
make install

cd zlib
mv zconf.h.included zconf.h
cd ..