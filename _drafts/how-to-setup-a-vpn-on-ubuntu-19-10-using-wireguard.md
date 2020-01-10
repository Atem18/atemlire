---
title: How to setup a VPN on Ubuntu 19.10 using Wireguard

---
Today, we will learn how to setup Wireguard as VPN.

We will be using Ubuntu 19.10 as I am using it for my Raspberry Pi 4 but except for the install part, you should be able to follow that tutorial on any other recent Linux distribution.

Keep also in mind that Wireguard is different than OpenVPN for example because there is no concept of client/server, but only peers. So in my example, I will be using the Ubuntu as a « server » and the iOS as a « client » but in reality it’s just a point to point VPN between two machines.

## Installation

Wireguard is already included in Ubuntu’s main repositories so you only have to call APT to install it:

```bash
apt install wireguard
```

As Wireguard is a kernel module, soon to be mainlined (included inside the Linux kernel): [https://arstechnica.com/gadgets/2019/12/wireguard-vpn-is-a-step-closer-to-mainstream-adoption/](https://arstechnica.com/gadgets/2019/12/wireguard-vpn-is-a-step-closer-to-mainstream-adoption/ "https://arstechnica.com/gadgets/2019/12/wireguard-vpn-is-a-step-closer-to-mainstream-adoption/"), you will need to check if it’s enabled and enable it if it’s not.

To check if you will have to do so:

```bash
lsmod | grep wireguard
```

If it’s ok, you will get something like this:

```bash
root@ubuntu:~# lsmod | grep wireguard
wireguard             208896  0
ip6_udp_tunnel         16384  1 wireguard
udp_tunnel             16384  1 wireguard
root@ubuntu:~#
```

If you get nothing, you will have to enable it either :

* Manually for one time:

```bash
modprobe wireguard
```

* Automatically so it starts at boot:

```bash
echo "wireguard" > /etc/modules-load.d/wireguard.conf
```

In my fresh Ubuntu 19.10 installation, I had to enable it manually.

## Configuration

There are many ways to configure Wireguard. I will present you one that works but feel free to research for other methods.

Wireguard works kinda like OpenSSH, each peer have a pair of private and public key but  unlike OpenSSH, Wireguard needs to know each public keys and private IP address of each peer he will allow the connection.

### Server keys generation

Execute the following commands on Ubuntu which as said previously will be our « server »:

```bash
mkdir /etc/wireguard
cd /etc/wireguard
wg genkey | tee privatekey | wg pubkey > publickey
```

Then, create a configuration file for wg0 which will be our device for routing. 