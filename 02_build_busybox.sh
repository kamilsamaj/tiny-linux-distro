#!/bin/bash
source ./00_set_vars.sh

BUSYBOX_ARCHIVE="./src/busybox/busybox-${TINY_BUSYBOX_VERSION}.tar.bz2"
mkdir -p "$(dirname $BUSYBOX_ARCHIVE)"
if [ ! -f "$BUSYBOX_ARCHIVE" ]; then
    echo "downloading busybox source code ..."
    curl https://busybox.net/downloads/busybox-${TINY_BUSYBOX_VERSION}.tar.bz2 -o ${BUSYBOX_ARCHIVE}
fi

rm -rf ./src/busybox/busybox-${TINY_BUSYBOX_VERSION}

echo "unpacking busybox ..."
(
    cd ./src/busybox || exit 1
    tar -xf busybox-${TINY_BUSYBOX_VERSION}.tar.bz2
)

(
    echo "creating a default configuration"
    cd ./src/busybox/busybox-${TINY_BUSYBOX_VERSION} || exit 1
    make defconfig
    echo "CONFIG_STATIC=y" >> .config

    echo "compiling busybox ..."
    make -j$(nproc)
)

echo "busybox successfully compiled"
