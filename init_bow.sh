#!/bin/bash

# Install Docker
sudo apt-get update
sudo apt-get install apt-transport-https ca-certificates curl software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install docker-ce -y

# Set default shell from bash to zsh
sudo mv /bin/bash /bin/bashbin && \
sudo cat '#!/bin/sh
if [ $SHELL = /bin/bash ]; then
  export SHELL=/bin/zsh
  exec $SHELL
else
  /bin/bashbin $*
fi' > /bin/bash

