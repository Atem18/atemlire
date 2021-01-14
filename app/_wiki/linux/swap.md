---
title: Swap
permalink: "/wiki/linux/swap/"

---
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