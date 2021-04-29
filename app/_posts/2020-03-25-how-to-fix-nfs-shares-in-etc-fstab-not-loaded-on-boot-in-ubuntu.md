---
title: How to fix nfs shares in /etc/fstab not loaded on boot in Ubuntu
toc: true
toc_sticky: true
tags: ubuntu, nfs
---
Hi,

Just a quick blog post to show you how to fix an NFS share that does not want to mount at boot on Ubuntu. I tested it on Ubuntu 19.10 but it should work also on 18.04 and following.

First check that the mount is ok when you do a manual:

    mount -a

If it's ok, then open the file **/etc/netplan/50-cloud-init.yaml.**

Inside, you should find the following:

    # This file is generated from information provided by
    # the datasource.  Changes to it will not persist across an instance.
    # To disable cloud-init's network configuration capabilities, write a file
    # /etc/cloud/cloud.cfg.d/99-disable-network-config.cfg with the following:
    # network: {config: disabled}
    network:
        ethernets:
            eth0:
                dhcp4: true
                optional: true
        version: 2

To fix the problem, change **optional: true** to **optional: false** like the following:

    # This file is generated from information provided by
    # the datasource.  Changes to it will not persist across an instance.
    # To disable cloud-init's network configuration capabilities, write a file
    # /etc/cloud/cloud.cfg.d/99-disable-network-config.cfg with the following:
    # network: {config: disabled}
    network:
        ethernets:
            eth0:
                dhcp4: true
                optional: false
        version: 2

That's all, hope you enjoyed the quick fix just like I did !