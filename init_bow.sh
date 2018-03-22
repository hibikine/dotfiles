#!/bin/bash

# Install Docker
sudo apt-get update
sudo apt-get install apt-transport-https ca-certificates curl software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" -y
sudo apt-get update
sudo apt-get install docker-ce -y
touch $HOME/.dotconfig
echo "export DOCKER_TLS_VERIFY=\"1\"
export DOCKER_HOST=\"tcp://192.168.99.100:2376\"
export DOCKER_CERT_PATH=\"/mnt/c/Users/goods/.docker/machine/machines/default\"
export DOCKER_MACHINE_NAME=\"default\"" >> $HOME.dotconfig

# Set default shell from bash to zsh
sudo mv /bin/bash /bin/bashbin && \
    sudo cat '#!/bin/sh
if [ $SHELL = /bin/bash ]; then
  export SHELL=/bin/zsh
  exec $SHELL
else
  /bin/bashbin $*
fi' > /bin/bash && \
    sudo chmod 755 /bin/bash

