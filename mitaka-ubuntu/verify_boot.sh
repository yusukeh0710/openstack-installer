#!/bin/bash
source ~/demo-openrc.sh
openstack image list
openstack network list
openstack security group list
openstack flavor list

NETID=`openstack network list | grep demo-net | awk '{print $2}'`
SECGRPID=`openstack security group list | grep default | awk '{print $2}'`
nova boot --flavor m1.tiny --image "cirros-0.3.4-x86_64" \
 --nic net-id=${NETID} \
 --security-group ${SECGRPID} vm
