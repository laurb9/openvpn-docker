#!/bin/bash -x
IMAGE=openvpn
docker run --rm -it \
           --name openvpn-client \
           --cap-add NET_ADMIN \
           --device /dev/net/tun \
           --volume "$(pwd)/client.conf:/etc/openvpn/openvpn.conf:ro" \
           --volume "$(pwd)/pki:/etc/openvpn/pki:ro" \
           --volume "$(pwd)/ta.key:/etc/openvpn/ta.key:ro" \
           $IMAGE
