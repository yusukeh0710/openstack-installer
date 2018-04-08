#!/bin/bash
source admin-openrc.sh
source demo.ini

# Create demo networks
openstack network create --external \
  --provider-physical-network provider --provider-network-type flat ext-net

openstack subnet create --no-dhcp \
  --subnet-range ${EXT_SUBNET_RANGE} --gateway ${EXT_GATEWAY} \
  --allocation-pool start=${EXT_START_IP},end=${EXT_END_IP} \
  --network ext-net ext-subnet

openstack network create user-net

openstack subnet create \
  --subnet-range ${INT_SUBNET_RANGE} --gateway ${INT_GATEWAY} \
  --dns-nameserver 8.8.8.8 \
  --network user-net user-subnet

openstack router create router
openstack router set router --external-gateway ext-net
openstack router add subnet router user-subnet
openstack router show router

# Create security group rule to pass all received/sent data.
for gid in $(openstack security group list -f value | awk '{print $1}'); do
  neutron security-group-rule-create --direction ingress --ethertype IPv4 ${gid}
done

# Create flavor
openstack flavor create --public m1.tiny --id 0 --ram 512 --disk 1 --vcpus 1
openstack flavor create --public m1.small --id 1 --ram 1024 --disk 5 --vcpus 1
openstack flavor create --public m1.medium --id 2 --ram 2048 --disk 20 --vcpus 1
openstack flavor create --public m1.large --id 3 --ram 4096 --disk 40 --vcpus 2
openstack flavor create --public m1.xlarge --id 4 --ram 8192 --disk 80 --vcpus 4

# Open port in firewall to breaking connection by iptables configured in installing docker.
./utils/open_port_in_firewall.sh
