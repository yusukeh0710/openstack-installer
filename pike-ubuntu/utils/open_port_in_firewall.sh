#!/bin/bash
for br_dev in $(ifconfig | grep brq | awk '{print $1}'); do
  sudo iptables -A FORWARD -i ${br_dev} -o ${br_dev} -j ACCEPT
done
