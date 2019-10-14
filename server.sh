#!/bin/bash -x
IMAGE=openvpn
docker run --rm -it \
           --name openvpn-server \
           --cap-add NET_ADMIN \
           --device /dev/net/tun \
           --publish 1194:1194/tcp \
           --volume "$(pwd)/server.conf:/etc/openvpn/openvpn.conf:ro" \
           --volume "$(pwd)/pki:/etc/openvpn/pki:ro" \
           --volume "$(pwd)/ta.key:/etc/openvpn/ta.key:ro" \
           $IMAGE
