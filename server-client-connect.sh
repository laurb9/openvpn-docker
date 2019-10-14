#!/bin/bash -x
iptables -t nat -A POSTROUTING --src ${ifconfig_pool_remote_ip}/32 -o eth0 -j MASQUERADE
