#!/bin/bash

if [[ "$1" == "reset" ]]
then
  sudo apt-mark unhold kubelet kubeadm kubectl
  yes | sudo kubeadm reset
  sudo systemctl restart kubelet
  sudo apt purge kubeadm -y
  sudo apt purge kubelet -y
  sudo apt purge kubectl -y
  exit 1
fi

# install kubernetes cluster
sudo swapoff -a

sudo sed -i.bak -r 's/(.+ swap .+)/#\1/' /etc/fstab

# update package
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl
sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list


sudo apt-get update

# echo "============================"
# echo "Enter the user K8s Version"
# echo "1.18.4"
# echo "1.21.12"
# echo "1.22.9"
# echo "1.23.6"
# echo "1.24.0"
# echo "version: "
# read version
# version=$version"-00"
# echo "Entered Version: $version"
version="1.23.6-00"
echo "============================"
echo "Install start"
echo "============================"

sleep 1

# install kubelet, kubeadm, kubectl
sudo apt-get install -y kubelet=${version} kubeadm=${version} kubectl=${version}


# version hold
sudo apt-mark hold kubelet kubeadm kubectl

# if CentOS
# setenforce 0
# sed -i 's/^SELINUX=enforcing $/SELINUX=permissive/' /etc/selinux/config


# config bridge network using br_betfilter
cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
br_netfilter
EOF

cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sudo sysctl --system


# config DNS
# if you want custom DNS server, Uncomment below 4 lines and run.

# sudo cat <<EOF > /etc/resolv.conf
# nameserver 1.1.1.1
# nameserver 8.8.8.8
# EOF
