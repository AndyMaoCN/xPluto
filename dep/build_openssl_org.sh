#!/bin/bash

DEP_ROOT=`pwd`

cd openssl
OPENSSL_PATH=`pwd`
echo $OPENSSL_PATH

./config --prefix=$DEP_ROOT/install_linux/openssl shared zlib
make
make install
