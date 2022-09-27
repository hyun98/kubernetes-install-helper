#!/bin/bash

if [ -z $1 ]
then
    echo "Need Worker Node Number"
    exit 1
fi

WORKER_NUM=$1

curl -sfL https://get.k3s.io | K3S_URL=https://$MASTER_IP:6443 \
K3S_TOKEN=$NODE_TOKEN \
INSTALL_K3S_EXEC="--node-name aomd-worker${WORKER_NUM} --docker" \
INSTALL_K3S_VERSION="v1.23.6+k3s1" sh -s -
