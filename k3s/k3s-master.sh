#!/bin/bash

sudo apt update

curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="\
--disable traefik \
--disable metrics-server \
--node-name aomd-master --docker" \
INSTALL_K3S_VERSION="v1.18.6+k3s1" sh -s -

mkdir ~/.kube
sudo cp /etc/rancher/k3s/k3s.yaml ~/.kube/config
sudo chown -R $(id -u):$(id -g) ~/.kube
echo "export KUBECONFIG=~/.kube/config" >> ~/.bashrc
echo "alias k='kubectl'" >> ~/.bashrc
source ~/.bashrc
