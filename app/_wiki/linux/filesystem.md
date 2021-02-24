---
title: Filesystem
permalink: "/wiki/linux/filesystem/"

---
## General

### Rescan physical disk after increased size

```bash
echo 1 > /sys/block/sda/device/rescan
```

### Get total files size by year
```bash
find . -type f -printf '%TY %s\n' | awk '{b[$1]+=$2} END{for (date in b) printf "%s %5.1f MiB\n", date, b[date]/1024**2}' | sort
```

### Get total files size by month
```bash
find . -type f -printf '%TY-%Tm %s\n' | awk '{b[$1]+=$2} END{for (date in b) printf "%s %5.1f MiB\n", date, b[date]/1024**2}' | sort
```

### Get total files size by day
```bash
find . -type f -printf '%TY-%Tm-%Td %s\n' | awk '{b[$1]+=$2} END{for (date in b) printf "%s %5.1f MiB\n", date, b[date]/1024**2}' | sort
```