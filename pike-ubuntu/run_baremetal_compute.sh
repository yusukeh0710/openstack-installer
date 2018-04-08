#!/bin/bash
source compute.ini
sudo  apt -y update
sudo  apt install -y software-properties-common
sudo  add-apt-repository cloud-archive:pike
sudo  apt -y update -q && apt -y upgrade

sudo apt install -y python-openstackclient python-memcache nova-compute neutron-linuxbridge-agent virt-manager

sudo cp conf/compute/nova.conf /etc/nova/nova.conf
sudo -E sed -i "s/CTRL_IP/${CTRL_IP}/g" /etc/nova/nova.conf
sudo -E sed -i "s/COMPUTE_IP/${COMPUTE_IP}/g" /etc/nova/nova.conf

sudo cp conf/compute/neutron.conf /etc/neutron/neutron.conf
sudo cp conf/compute/linuxbridge_agent.ini /etc/neutron/plugins/ml2/linuxbridge_agent.ini
sudo -E sed -i "s/COMPUTE_IP/${COMPUTE_IP}/g" /etc/neutron/plugins/ml2/linuxbridge_agent.ini
sudo -E sed -i "s/COMPUTE_NIC/${COMPUTE_NIC}/g" /etc/neutron/plugins/ml2/linuxbridge_agent.ini

sudo -E sh -c "echo ${CTRL_IP} controller >> /etc/hosts"
sudo scripts/restart_compute.sh
