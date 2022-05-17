#!/bin/bash

# init K8s
sudo kubeadm init --token-ttl 0 --pod-network-cidr=172.16.0.0/16 >> kubeadm-init-result.txt

sudo rm k8s-token.txt

# token saved at k8s-token.txt
# This token has no expiry date
cat kubeadm-init-result.txt | tail -2 >> k8s-token.txt

sudo rm kubeadm-init-result.txt

# config for master only
# Master get kubectl privileges
mkdir -p $HOME/.kube
sudo rm -f $HOME/.kube/config
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config


# config Calico network
curl https://projectcalico.docs.tigera.io/manifests/calico.yaml -O
kubectl apply -f calico.yaml

