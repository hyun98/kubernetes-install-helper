#!/bin/bash

echo "=============================="
echo "======= INSTALL DOCKER ======="
echo "=============================="

# Check Ubuntu Version
VERSION=$(cat /etc/issue)


if [[ "$VERSION" == *"Ubuntu"* ]]; then
echo "Server platform is "$VERSION
else
echo "Only available Linux/Ubuntu"
exit 1
fi


# update & upgrade package
sudo apt-get update
sudo apt-get upgrade -y


if [[ "$VERSION" == *"Ubuntu 18."* ]]; then

# Install Docker using the repository
sudo apt install apt-transport-https ca-certificates curl software-properties-common

sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"

sudo apt update
sudo apt-cache policy docker-ce
sudo apt install docker-ce
sudo systemctl status docker

elif [[ "$VERSION" == *"Ubuntu 20."* ]]; then

# Install Docker using the repository
sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  
sudo apt-get update
sudo apt-get -y install docker-ce docker-ce-cli containerd.io docker-compose-plugin

fi

# Grant docker.sock privileges to the current user
sudo usermod -a -G docker $USER
sudo chown "$USER":"$USER" /home/"$USER"/.docker -R
sudo chmod g+rwx "/home/$USER/.docker" -R

# Apply changes
sudo service docker stop
sudo service docker start

# Config docker group
# cgroupfs -> systemd
cat <<EOF | sudo tee /etc/docker/daemon.json
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2"
}
EOF
