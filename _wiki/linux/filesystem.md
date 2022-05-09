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

### Get total files by year
```bash
find . -type f -printf '%TY\n' | sort | uniq -c
```

### Get total files by month
```bash
find . -type f -printf '%TY-%Tm\n' | sort | uniq -c
```

### Get total files by day
```bash
find . -type f -printf '%TY-%Tm-%Td\n' | sort | uniq -c
```

### Find files between two dates
```bash
find . -type f -newermt "1970-01-01 00:00:00" ! -newermt "1970-01-01 23:59:59"
```