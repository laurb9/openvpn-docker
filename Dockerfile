FROM debian:10.1 as openvpn

# Install necessary packages
RUN apt-get update \
 && apt-get install -y \
            openvpn \
            easy-rsa \
            vim \
            tshark \
            tcpdump \
            iptables \
            telnet \
            curl \
            procps \
            less \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /etc/openvpn
COPY client.conf server.conf server-client-*.sh /etc/openvpn/
EXPOSE 1194/tcp
EXPOSE 1194/udp

# openvpn.conf is missing intentionally to be explicit when we want server or client.
CMD openvpn openvpn.conf

