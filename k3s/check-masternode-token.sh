#!/bin/bash

echo "====== MASTER NODE TOKEN ======"
NODE_TOKEN=$(sudo cat /var/lib/rancher/k3s/server/node-token)
echo $NODE_TOKEN

echo "========= MASTER IP =========="
MASTER_IP=$(kubectl get node aomd-master -ojsonpath="{.status.addresses[0].address}")
echo $MASTER_IP