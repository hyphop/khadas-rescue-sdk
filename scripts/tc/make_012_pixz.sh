#!/bin/sh

## hyphop ##

#= make xz

D=$(dirname $0)

. $D/make_

VER=1.0.6
NAME=pixz
PKG=$NAME-$VER.tar.gz

echo "[i] make $PKG">&2

../download https://github.com/vasi/pixz/releases/download/v$VER/$NAME-$VER.tar.gz || exit 1

cd $DL

D=${PKG%.tar.*}

[ -d "$D" ] || \
    tar -xf $PKG

cd $D

export CFLAGS="-I$PRE2/include"
export LDFLAGS="-L$PRE2/lib -Wl,-rpath=$PRE2/lib -llzma -larchive"
export LIBARCHIVE_CFLAGS="$CFLAGS"
export LIBARCHIVE_LIBS="$LDFLAGS"
export LZMA_CFLAGS="$CFLAGS"
export LZMA_LIBS="$LDFLAGS"

#export LT_SYS_LIBRARY_PATH=$PRE2/lib
#export PKG_CONFIG_PATH=$PRE2

#make clean

#autoreconf -B $PRE2/lib

./configure --prefix="$PRE2"  && \
    make $MAKE_MT && \
	make install
