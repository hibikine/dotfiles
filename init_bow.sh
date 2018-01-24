#!/bin/bash

# Install Docker
apt-get update
apt-get install apt-transport-https ca-certificates curl software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
apt-key fingerprint 0EBFCD88
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt-get update
apt-get install docker-ce -y

# Set default shell from bash to zsh
mv /bin/bash /bin/bashbin && \
cat '#!/bin/sh
if [ $SHELL = /bin/bash ]; then
  export SHELL=/bin/zsh
  exec $SHELL
else
  /bin/bashbin $*
fi' > /bin/bash

