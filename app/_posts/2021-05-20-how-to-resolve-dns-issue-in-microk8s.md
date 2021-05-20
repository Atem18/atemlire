---
title: How to resolve DNS issue in MicroK8s

---
Hi folks, today, we will learn how to resolve DNS issue in MicroK8s.

If like me you happened to discover that you don't have internet in your pod but can ping 8.8.8.8, then you most likely have a DNS issue.

Also, there is a good chance that the issue might be this one: [https://kubernetes.io/docs/tasks/administer-cluster/dns-debugging-resolution/#known-issues](https://kubernetes.io/docs/tasks/administer-cluster/dns-debugging-resolution/#known-issues "https://kubernetes.io/docs/tasks/administer-cluster/dns-debugging-resolution/#known-issues")

To solve it, you need to edit the file /var/snap/microk8s/current/args/kubelet in all of your MicroK8s nodes and add at the end of the file:

    --resolv-conf=/run/systemd/resolve/resolv.conf

Then restart kubelet :

    systemctl restart snap.microk8s.daemon-kubelet

Finally, restart CoreDNS:

    microk8s kubectl rollout restart -n kube-system deployment/coredns

You should also restart any pod that was affected by the issue with:

     microk8s kubectl rollout restart deployment mypod

  
That's all folks !