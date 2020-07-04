---
title: How to create your own adblock

---
Hi folks, today we will learn how to build your own adblock, one that does not sell your navigation data to big corporations.

’’’bash
#!/bin/bash
    
curl -s -o /etc/dnsmasq-adblock https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts
    
cat /etc/dnsmasq-custom > /etc/dnsmasq-hosts.conf
    
cat /etc/dnsmasq-adblock >> /etc/dnsmasq-hosts.conf
    
systemctl restart dnsmasq
’’’