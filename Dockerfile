FROM ubuntu:18.04
MAINTAINER Hibikine Kage <mail@hibikine.me>

# apt update
RUN apt update
RUN apt install -y sudo make

# add sudo user
RUN groupadd -g 1000 hibikine && \
    useradd  -g      hibikine -G sudo -m -s /bin/bash hibikine && \
    echo 'hibikine:hogehoge' | chpasswd

RUN echo 'Defaults visiblepw'              >> /etc/sudoers
RUN echo 'hibikine ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER hibikine

WORKDIR /home/hibikine/dotfiles