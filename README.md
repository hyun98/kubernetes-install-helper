# kubernetes-install-helper
### This project can speed up Kubernetes installation time Maybe..

 > You can install docker, kubectl, kubelet and kubeadm. <br> K8s will be installed by kubeadm
 

--- 
### Test Done list
> Test at just created server
#### docker.sh
- Ubuntu 18.04.6
- Ubuntu 20.04.4

#### config-k8s.sh
- Ubuntu 18.04.6
- Ubuntu 20.04.4

 ---
<br>

## Download this Repository
```
git clone https://github.com/hyun98/kubernetes-install-helper.git

cd /kubernetes-install-helper
```

`0.1 Iffff the file does not run, change the permissions to executable`
```
sudo chmod +x ./config-k8s.sh ./docker.sh ./master.sh
```

<br>

`1. Install Container Runtime > We use docker`

```
./docker.sh
```

<br>

`2.1 Setup k8s configuration`

```
./config-k8s.sh
```

<br>

`2.2 If you want reset kubeadm, kubelet, kubectl ...`
```
./config-k8s.sh reset
```

<br>

`3. Set the current node as the master node`<br>
`kubernetes network policy : 'Calico'`
```
./master.sh
```
> token saved at k8s-token.txt<br> This token has no expiry date


<br>

`4. Add worker node`

> example
```
sudo kubeadm join 10.0.2.4:6443 --token y066kk.g60l4xjdbgb5k4t7 \
        --discovery-token-ca-cert-hash sha256:c58fdb2113aae3f8fab21ed88accf5720608c13694577f73c4ed56fb7907b706
```

```
If you add Worker Node, you should find command at Master's k8s-token.txt
And you should prepend 'sudo' to the command
```

<br>

`5. Test working`

```
kubectl get all -A
```
![image](https://user-images.githubusercontent.com/68914294/168919001-1c60af64-9ca1-4269-8cd4-60c5bf407cc8.png)


```
cd test

kubectl apply -f nginx.yaml

# wait for pod ..

curl localhost:30000
```