---
title: How to easily create your own adblock using Dnsmasq
toc: true
toc_sticky: true

---
Hi folks, today we will learn how to build your own adblock, one that does not sell your navigation data to big corporations.

We will be using Dnsmasq as our DNS server which will have a list of domains to block (spoiler: domain ads). And we will update that list everyday by cron. Of course that means that you should then update your DNS to use the one we are configuring.

## Installation

For Debian

```bash
apt update && apt install dnsmasq
```

For CentOS

```bash
yum update && yum install dnsmasq
```

## Configuration

We copy the original file in case we want to restore it

```bash
cp /etc/dnsmasq.conf /etc/dnsmasq.conf.ori
```

Then create a configuration file named **/etc/dnsmasq.conf** and put the following content

```bash
domain-needed
bogus-priv
resolv-file=/etc/dnsmasq-dns.conf
strict-order
user=dnsmasq
group=dnsmasq
addn-hosts=/etc/dnsmasq-hosts.conf
expand-hosts
domain=mydomain.lan
```

Replace mydomain.lan by a custom domain you would like to be served via your DNS.  
Omit the line if you don't want to serve one.

### DNS

Open your firewall on port 53 both in UDP and TCP.

Create a file named **/etc/dnsmasq-dns.conf** and put the following inside:

```bash
nameserver 1.1.1.1
nameserver 1.0.0.1
```

If you don't like Cloudflare's DNS, feel free to use others.  
  
If you've put the line "domain" in /etc/dnsmasq.conf, then create a file named **/etc/dnsmasq-custom.conf** where you will put custom domain resolution like :

    127.0.0.1 alpha
    127.0.0.1 beta

They will resolve as alpha.mydomain.lan and beta.mydomain.lan

### CRON

Create a file called **/etc/cron.daily/adblocker** and put the following content

```bash
#!/bin/bash

curl -s -o /etc/dnsmasq-adblock https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts

cat /etc/dnsmasq-custom > /etc/dnsmasq-hosts.conf

cat /etc/dnsmasq-adblock >> /etc/dnsmasq-hosts.conf

systemctl restart dnsmasq
```

Basically what we are doing is :

* getting the last version of the ads domains
* put any custom domain to dnsmasq hosts file
* append ads domain to the previous list
* restart dnsmasq

We are using the excellent project [https://github.com/StevenBlack/hosts](https://github.com/StevenBlack/hosts)

Feel free to use another list or even run your own. It will work as long as it's a list in the same format than an hosts file.

## Conclusion

Setting up and maintaining your own adblock is really easy.

Also if you wish to use it as you go like on your mobile phone, feel free to use my tutorial about [Wireguard](/how-to-setup-a-vpn-on-ubuntu-using-wireguard/).

  
That's all folks!