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

All the following commands will be performed on Ubuntu which as said previously will be our « server ».

### Server keys generation

Create private and public keys

```bash
mkdir /etc/wireguard
cd /etc/wireguard
wg genkey | tee privatekey | wg pubkey > publickey
```

Then, create a configuration file for wg0 which will be our device for routing.

    /etc/wireguard/wg0.conf

```bash
[Interface]
Address = 192.168.2.1/24
ListenPort = 51820
PrivateKey = SERVER_PRIVATE_KEY

# note - substitute eth0 in the following lines to match the Internet-facing interface
# if the server is behind a router and receive traffic via NAT, this iptables rules are not needed
PostUp = iptables -A FORWARD -i %i -j ACCEPT; iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
PostDown = iptables -D FORWARD -i %i -j ACCEPT; iptables -t nat -D POSTROUTING -o eth0 -j MASQUERADE

[Peer]
# iphone
PublicKey = PEER_IPHONE_PUBLIC_KEY
AllowedIPs = 192.168.2.2/32
```

### Client keys generation

We will host "clients" keys and configuration files on the "server" in that example. But you can also generate them on your client and keep them safely there. It's up to you.

Create a new directory to put client's configuration files

```bash
mkdir -p /etc/wireguard/clients/iphone
```

Generate private and public keys

```bash
mkdir /etc/wireguard
cd /etc/wireguard
wg genkey | tee privatekey | wg pubkey > publickey
```

Create client's configuration file

    /etc/wireguard/clients/iphone/iphone.conf

```bash
[Interface]
Address = 192.168.2.2/24
PrivateKey = PEER_IPHONE_PRIVATE_KEY
DNS = 192.168.2.1

[Peer]
PublicKey = SERVER_PUBLICKEY
PresharedKey = PRE-SHARED_KEY
AllowedIPs = 0.0.0.0/0, ::/0
Endpoint = ubuntu.mydomain.com:51820
```