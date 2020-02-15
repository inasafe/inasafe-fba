#!/usr/bin/env bash

# Run as sudo

apt -y update; apt -y install net-tools
export IP_ADDR=$(ifconfig docker0 | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}')
echo $IP_ADDR > ip-address.txt
cat ip-address.txt
sed -i "s/127.0.0.1/${IP_ADDR}/g" /etc/hosts
cat /etc/hosts
