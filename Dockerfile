FROM alpine AS builder
LABEL org.opencontainers.image.authors="Kenzo Okuda <kyokuheki@gmail.com>"

RUN set -x \
 && apk add --no-cache \
    perl \
    perl-lwp-protocol-https \
    perl-text-csv \
    curl

RUN set -x \
 && mkdir -vp /ieee-data/oui /ieee-data/oui28 /ieee-data/oui36 /ieee-data/iab \
 && curl -vsSL https://raw.githubusercontent.com/royhills/arp-scan/1.10.0/get-oui -o /get-oui \
 && curl -vsSL https://standards-oui.ieee.org/oui/oui.csv -o /ieee-data/oui/oui.csv \
 && curl -vsSL https://standards-oui.ieee.org/oui28/mam.csv -o /ieee-data/oui28/mam.csv \
 && curl -vsSL https://standards-oui.ieee.org/oui36/oui36.csv -o /ieee-data/oui36/oui36.csv \
 && curl -vsSL https://standards-oui.ieee.org/iab/iab.csv -o /ieee-data/iab/iab.csv

RUN set -x \
 && sed -i -r 's@https://standards-oui.ieee.org/@file:///ieee-data/@g' /get-oui \
 && chmod -v +x /get-oui \
 && /get-oui -v -f /ieee-data/ieee-oui.txt \
 && echo -e '00AE\tSoftEther (Virtual Hub)' >> /ieee-data/mac-vendor.txt

FROM alpine
LABEL org.opencontainers.image.authors="Kenzo Okuda <kyokuheki@gmail.com>"

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
    arp-scan \
    mtr \
    tcptraceroute \
    iperf \
    iperf3 \
    speedtest-cli \
    bind-tools \
    drill \
    ldns-tools \
    corkscrew \
    tar \
    pciutils
# httping proxytunnel lft lsh-client mosh

COPY --from=builder /ieee-data/ieee-oui.txt /usr/share/arp-scan/ieee-oui.txt
COPY --from=builder /ieee-data/mac-vendor.txt /usr/share/arp-scan/mac-vendor.txt

#ENTRYPOINT ["/bin/bash", "-li"]
CMD ["/bin/bash", "-li"]
