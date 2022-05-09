---
title: Kubernetes
permalink: "/wiki/devops/containers/kubernetes/"
---

## Create a secret to get a private image from DockerHub and set it in the deployment
```bash
kubectl create secret docker-registry regcred --docker-username=<username> --docker-password="<password>" --docker-email=<email> -n <namespace>
```

```yaml
spec:
  containers:
    imagePullSecrets:
      - name: regcred
```