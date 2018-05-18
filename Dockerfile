FROM ubuntu:rolling
LABEL maintainer Kyokuheki <kyokuheki@gmail.com>

ENV LANG=C.UTF-8 \
    LC_ALL=C.UTF-8 \
    DEBIAN_FRONTEND=noninteractive

RUN set -x \
 && apt-get update && apt-get install -y \
    iproute2 \
    net-tools \
    ssh \
    putty-tools \
    mosh \
    lsh-client \
    tcpdump \
    nmap \
    netcat-openbsd \
    telnet \
    socat \
    iputils-arping \
    iputils-ping \
    fping \
    dhcping \
    hping3 \
    httping \
    lft \
    mtr-tiny \
    traceroute \
    iputils-tracepath \
    iperf \
    iperf3 \
    speedtest-cli \
    bind9-host \
    bind9utils \
    dnsutils \
    ldnsutils \
    proxytunnel \
 && apt-get clean && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

RUN apt-get update

#ENTRYPOINT ["bash"]
