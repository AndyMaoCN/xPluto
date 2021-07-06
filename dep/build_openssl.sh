#!/bin/bash

CMAKE='cmake'
BUILD_DIR='linux_build_openssl'
DEP_ROOT=`pwd`

cd openssl
OPENSSL_PATH=`pwd`
echo $OPENSSL_PATH
cd ..

if [ ! -d $BUILD_DIR ]; then
    mkdir $BUILD_DIR
fi
cd $BUILD_DIR

$CMAKE $OPENSSL_PATH -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$DEP_ROOT/install_linux/openssl -DBUILD_SHARED_LIBS=on
make
make install
