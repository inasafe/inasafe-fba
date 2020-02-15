#!/usr/bin/env bash

# Run as sudo

echo "Using IP ADDRESS: $IP_ADDR"
apt -y update; apt -y install dnsmasq
cat >> /etc/dnsmasq.conf << EOL
server=1.1.1.1
server=8.8.8.8
address=/test/$IP_ADDR
EOL

echo "nameserver $IP_ADDR" >> /etc/resolv.conf
service dnsmasq restart
