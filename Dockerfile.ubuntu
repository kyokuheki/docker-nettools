FROM ubuntu:devel
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
    curl \
    wget \
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
    arp-scan \
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

RUN set -x \
 && get-oui -v -f /usr/share/arp-scan/ieee-oui.txt -u http://standards-oui.ieee.org/oui.txt \
 && get-iab -v -f /usr/share/arp-scan/ieee-iab.txt -u http://standards-oui.ieee.org/iab/iab.txt \
 && echo '00AE	SoftEther (Virtual Hub)' >> /usr/share/arp-scan/mac-vendor.txt

RUN apt-get update

#ENTRYPOINT ["/bin/bash"]
CMD ["/bin/bash"]
