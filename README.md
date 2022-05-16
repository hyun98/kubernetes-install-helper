# kubernetes-install-helper
### This project can speed up Kubernetes installation time Maybe..

 > You can install docker, kubectl, kubelet and kubeadm. <br> K8s will be installed by kubeadm
 

--- 
### Test Done list
#### docker.sh
- Ubuntu 18.04.6

#### config-k8s.sh
- Ubuntu 18.04.6

 ---
<br>

`0. If the file does not run, change the permissions to executable`
```
sudo chmod +x ./config-k8s.sh ./docker.sh ./master.sh
```

<br>

`1.1 Setup k8s configuration`

```
./config-k8s.sh
```

<br>

`1.2 If you want reset kubeadm, kubelet, kubectl`
```
./config-k8s.sh reset
```

<br>

`2. Install Container Runtime > We use docker`

```
./docker.sh
```

<br>

`3. Set the current node as the master node`
```
./master.sh
```
> token saved at k8s-token.txt<br> This token has no expiry date


<br>

`4. Add worker node`
```
If you add Worker Node, you can find command at Master's k8s-token.txt
And you should prepend 'sudo' to the command
```