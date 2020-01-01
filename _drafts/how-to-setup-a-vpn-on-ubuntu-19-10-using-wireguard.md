---
title: How to setup a VPN on Ubuntu 19.10 using Wireguard

---
Today, we will learn how to setup Wireguard. We will be using Ubuntu 19.10 as I am using it for my Raspberry Pi 4 but except for the install part, you should be able to follow that tutorial on any other recent Linux distribution.

# Installation

Wireguard is already included in Ubuntu’s main repositories so you only have to call APT to install it:

    apt install wireguard

As Wireguard is a kernel module, soon to be mainlined (included inside the Linux kernel) : [https://arstechnica.com/gadgets/2019/12/wireguard-vpn-is-a-step-closer-to-mainstream-adoption/](https://arstechnica.com/gadgets/2019/12/wireguard-vpn-is-a-step-closer-to-mainstream-adoption/ "https://arstechnica.com/gadgets/2019/12/wireguard-vpn-is-a-step-closer-to-mainstream-adoption/"), you will need to check if it’s enabled and enable it if it’s not.

To check if you will have to do so:

    lsmod | grep wireguard

If it’s ok, you will get something like this:

    root@ubuntu:~# lsmod | grep wireguard
    wireguard             208896  0
    ip6_udp_tunnel         16384  1 wireguard
    udp_tunnel             16384  1 wireguard
    root@ubuntu:~#

In my fresh Ubuntu 19.10 installation, I had to enable it manually.