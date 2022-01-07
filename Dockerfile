FROM alpine:edge as builder
LABEL maintainer Kenzo Okuda <kyokuheki@gmail.com>

RUN set -x \
 && apk add --no-cache -X https://dl-cdn.alpinelinux.org/alpine/edge/testing\
    arp-scan \
    perl \
    perl-libwww \
 && get-oui -v -f /usr/share/arp-scan/ieee-oui.txt -u http://standards-oui.ieee.org/oui.txt \
 && get-iab -v -f /usr/share/arp-scan/ieee-iab.txt -u http://standards-oui.ieee.org/iab/iab.txt \
 && echo '00AE	SoftEther (Virtual Hub)' >> /usr/share/arp-scan/mac-vendor.txt

FROM alpine:edge
LABEL maintainer Kenzo Okuda <kyokuheki@gmail.com>

COPY --from=builder /usr/share/arp-scan/ieee-oui.txt /usr/share/arp-scan/ieee-oui.txt
COPY --from=builder /usr/share/arp-scan/ieee-iab.txt /usr/share/arp-scan/ieee-iab.txt

RUN set -x \
 && sed -i -e '$ a @testing https://dl-cdn.alpinelinux.org/alpine/edge/testing' /etc/apk/repositories \
 && apk add --no-cache \
    bash \
    coreutils \
    util-linux \
    sed \
    dhcpcd \
    iproute2 \
    net-tools \
    openssh \
    putty \
    tcpdump \
    nmap \
    curl \
    wget \
    netcat-openbsd \
    busybox-extras \
    socat \
    iputils \
    fping \
    dhcping \
    hping3@testing \
    arp-scan@testing \
    mtr \
    tcptraceroute \
    iperf \
    iperf3 \
    speedtest-cli \
    bind-tools \
    drill \
    ldns-tools \
    corkscrew@testing \
    tar
# httping proxytunnel lft lsh-client mosh

#ENTRYPOINT ["/bin/bash", "-li"]
CMD ["/bin/bash", "-li"]
