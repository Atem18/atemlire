---
title: How to create your own adblock

---
Hi folks, today we will learn how to build your own adblock, one that does not sell your navigation data to big corporations.

We will be using Dnsmasq as our DNS server which will have a list of domains to block (spoiler: domain ads). And we will update that list everyday by cron.

## Installation

For Debian

\`\`\`bash

apt update && apt install dnsmasq

\`\`\`

For CentOS

\`\`\`bash

yum update && yum install dnsmasq

\`\`\`

## Configuration

We move the original file in case we want to restore it

\`\`\`bash

mv /etc/dnsmasq.conf.ori /etc/dnsmasq.conf

\`\`\`

Then edit the configuration file /etc/dnsmasq.conf and put the following content

\`\`\`bash

domain-needed

bogus-priv

resolv-file=/etc/dnsmasq-dns.conf

strict-order

user=dnsmasq

group=dnsmasq

addn-hosts=/etc/dnsmasq-hosts.conf

expand-hosts

domain=kevin-messer.lan

\`\`\`

Replace domain by your personnal domain.

### DNS

Open your firewall on port 53 both in UDP and TCP.

Create a file named /etc/dnsmasq-dns.conf and put the following inside:

\`\`\`bash

nameserver 8.8.8.8

nameserver 8.8.4.4

\`\`\`

If you don't like Google's DNS, feel free to use others.

### CRON

Create a file called adblocker in /etc/cron.daily and put the following content

    /etc/cron.daily/adblocker

\`\`\`bash

\#!/bin/bash

curl -s -o /etc/dnsmasq-adblock https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts

cat /etc/dnsmasq-custom > /etc/dnsmasq-hosts.conf

cat /etc/dnsmasq-adblock >> /etc/dnsmasq-hosts.conf

systemctl restart dnsmasq

\`\`\`