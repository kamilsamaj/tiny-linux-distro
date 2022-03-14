# tiny-linux-distro

Build a tiny Linux distribution based on a vanilla Linux kernel and a BusyBox

## Build a vanilla Linux kernel

```shell
./01_build_kernel.sh
```

## Build BusyBox binary

```shell
./02_build_busybox.sh
```

## Create initrd root filesystem

```shell
./03_create_initrd.sh
```

## Start the system in QEMU

```shell
./04_start_qemu.sh
```

## Optional: Clean up everything

```shell
./05_clean_up.sh
```

# Links

* [BusyBox source code](https://busybox.net/downloads/)
* [Linux Kernel source code](https://mirrors.edge.kernel.org/pub/linux/kernel/v5.x/)
