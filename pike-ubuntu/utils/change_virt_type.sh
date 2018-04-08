#!/bin/bash
virt_type=$1
if [ -z "${virt_type}" ]; then
  echo "usage $0 VIRT_TYPE"
  exit 1
elif [ ${virt_type} != "kvm" ] && [ ${virt_type} != "qemu" ]; then
  echo "usage $0 {kvm | qemu}"
  exit 1
fi

sudo sed -i "s/^virt_type=.*/virt_type=${virt_type}/g" /etc/nova/nova-compute.conf
sudo service nova-compute restart
