---
title: Filesystem
permalink: "/wiki/linux/filesystem"

---
## General

### Rescan physical disk after increased size

```bash
echo 1 > /sys/block/sda/device/rescan
```