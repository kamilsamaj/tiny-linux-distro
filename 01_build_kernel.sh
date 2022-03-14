#!/bin/bash
source ./00_set_vars.sh

KERNEL_XZ="./src/linux-kernel/linux-${TINY_KERNEL_VERSION}.tar.xz"
KERNEL_MAJOR=$(echo $TINY_KERNEL_VERSION | sed 's/\([0-9]\+\)[^0-9].*/\1/')
mkdir -p "$(dirname $KERNEL_XZ)"
if [ ! -f "${KERNEL_XZ}" ]; then
    echo "downloading kernel source code ..."
    curl https://mirrors.edge.kernel.org/pub/linux/kernel/v${KERNEL_MAJOR}.x/linux-${TINY_KERNEL_VERSION}.tar.xz -o ./src/linux-kernel/linux-${TINY_KERNEL_VERSION}.tar.xz
fi

rm -rf ./src/linux-kernel/linux-${TINY_KERNEL_VERSION}

echo "unpacking linux-${TINY_KERNEL_VERSION}.tar.xz ..."
(
    cd ./src/linux-kernel || exit 1
    tar -xf linux-${TINY_KERNEL_VERSION}.tar.xz
)

echo "generating kernel default config"
(
    cd ./src/linux-kernel/linux-${TINY_KERNEL_VERSION} || exit 1
    make defconfig
)

echo "building kernel"
(
    cd ./src/linux-kernel/linux-${TINY_KERNEL_VERSION} || exit 1
    make bzImage -j$(nproc)
)
cp -v ./src/linux-kernel/linux-${TINY_KERNEL_VERSION}/arch/$(uname -m)/boot/bzImage .
echo "kernel successfully built"
