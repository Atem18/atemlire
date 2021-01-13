---
title: Linux
permalink: /wiki/linux/
---
## Dedicated subjects

* [Firewalld](/wiki/linux/firewalld)
* [RPM](/wiki/linux/rpm)
* [Swap](/wiki/linux/swap)

## Restore root password

### RHEL/CentOS

Reboot the server, and press e to edit the GRUB command line.

Add **rd.break** at the end of the linux16 line and press ctrl-x to boot in single user mode.

Mount the filesystem in rw:

```bash
mount -o remount,rw /sysroot
```

Chroot inside the folder:

```bash
chroot /sysroot
```

Then change the root password:

```bash
passwd root
```

If SELinux is installed and running, don't forget to relabel the FS:

```bash
touch /.autorelabel
```

Type **exit** twice and you are done.