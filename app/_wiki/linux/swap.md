---
title: Swap
permalink: "/wiki/linux/swap/"

---
## Find out which process is consuming Swap space

```bash
for file in /proc/*/status ; do awk '/Tgid|VmSwap|Name/{printf $2 " " $3}END{ print ""}' $file; done | grep kB  | sort -k 3 -n
```

## Creating and Activating a Swap File

```bash
fallocate -l 2G /swapfile
```

```bash
chmod 600 /swapfile
```

```bash
mkswap /swapfile
```

```bash
swapon /swapfile
```

```bash
echo "/swapfile swap swap defaults 0 0" >> /etc/fstab
````