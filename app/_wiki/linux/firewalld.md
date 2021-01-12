---
title: Firewalld
permalink: /wiki/linux/firewalld/
---
## Commands

## Reload Firewalld

```bash
firewall-cmd --reload
```

## Zones

### List zones

```bash
firewall-cmd --get-zones
```

### Add a new zone

```bash
firewall-cmd --new-zone=hetzner --permanent
```

### Assign interface to zone

```bash
firewall-cmd --zone=hetzner --change-interface=enp7s0 --permanent
```

## Services

## Assign service to zone

```bash
firewall-cmd --zone=hetzner --add-service=etcd-server --permanent
```