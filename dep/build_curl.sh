#!/bin/bash

# build with openssl use cmake will trigger find_package(OpenSSL)
# build with org make

BUILD_DIR='linux_build_curl'
DEP_ROOT=`pwd`

cd curl
CURL_PATH=`pwd`
echo $CURL_PATH

./configure --prefix=$DEP_ROOT/install_linux/curl --disable-shared -with-ssl=/root/doris/openssl_install

$CMAKE $CURL_PATH -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$DEP_ROOT/install_linux/openssl -DBUILD_SHARED_LIBS=on
make
make install
