---
title: Install K3S on Hetzner Cloud

---
\# Install K3S

export K3S_TOKEN=K10193dccd74a89f5f205c5feccd228c34273d3dba86e114d9e2586cdd8a698ffca::server:6e1dfc8108703f6ee7b1d0d9c8c3d0e7

curl -sfL [https://get.k3s.io](https://get.k3s.io "https://get.k3s.io") | sh -s - --cluster-init --disable local-storage --disable metrics-server --disable-cloud-controller --kubelet-arg="cloud-provider=external"

curl -sfL [https://get.k3s.io](https://get.k3s.io "https://get.k3s.io") | sh -s - --server https://10.0.0.2:6443 --disable local-storage --disable metrics-server --disable-cloud-controller --kubelet-arg="cloud-provider=external"

kubectl config view --raw >\~/.kube/config

\# Install Hcloud cloud controller

kubectl -n kube-system create secret generic hcloud --from-literal=token=zLQuPVNqiFxqy5sRaQTuk1b2NY8xjbHOIGnxnWsDdx4uNBduVxNMRPYzi6LJyRXt

kubectl apply -f [https://raw.githubusercontent.com/hetznercloud/hcloud-cloud-controller-manager/master/deploy/ccm.yaml](https://get.k3s.io "https://get.k3s.io")