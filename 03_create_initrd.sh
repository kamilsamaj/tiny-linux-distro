#!/bin/bash
source ./00_set_vars.sh

# clean up previous build
rm -rf ./build

# create common initrd directory structure
mkdir -p ./build/{bin,dev,sys,proc}

# copy busybox
cp -v ./src/busybox/busybox-${TINY_BUSYBOX_VERSION}/busybox ./build/bin/

# create symlinks to busybox
for prog in $(./build/bin/busybox --list); do
    ln -s /bin/busybox ./build/bin/$prog  # the path must start with /bin
done

# create a very simple init script
cat > ./build/init << EOF
#!/bin/sh

mount -t sysfs sysfs /sys
mount -t proc proc /proc
mount -t devtmpfs udev /dev
sysctl -w kernel.printk="2 4 1 7"
/bin/sh
poweroff -f
EOF

# create the initrd image
(
    cd ./build || exit 1
    chmod -R 777 .
    find . | cpio -o -H newc > ../initrd.img
)

echo "initrd.img successfully created"
