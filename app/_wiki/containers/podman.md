---
title: Podman
permalink: "/wiki/containers/podman/"

---
## Create a pod and expose ports

```bash
podman pod create --name pod-name -p 127.0.0.1:3306:3306
```