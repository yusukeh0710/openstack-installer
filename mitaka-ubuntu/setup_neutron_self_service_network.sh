#!/bin/bash
source openstack.ini

su -s /bin/sh -c "neutron-db-manage \
 --config-file /etc/neutron/neutron.conf \
 --config-file /etc/neutron/plugins/ml2/ml2_conf.ini upgrade head" neutron

service nova-api restart
service nova-compute restart

service neutron-server restart && \
 service neutron-linuxbridge-agent restart && \
 service neutron-dhcp-agent restart && \
 service neutron-metadata-agent restart && \
 service neutron-l3-agent restart

rm /var/lib/neutron/neutron.sqlite

apt-get install neutron-linuxbridge-agent


source ~/admin-openrc.sh
neutron net-create ext-net --router:external \
 --provider:physical_network provider --provider:network_type flat

neutron subnet-create ext-net --name ext-subnet \
  --allocation-pool start=${VM_IP_START},end=${VM_IP_END} \
  --disable-dhcp --gateway ${VM_GATEWAY} ${VM_NW}

source ~/demo-openrc.sh
neutron net-create demo-net
neutron subnet-create demo-net 192.168.0.0/24 \
--name demo-subnet --gateway 192.168.0.1 --dns-nameserver ${VM_GATEWAY}

neutron router-create demo-router
neutron router-interface-add demo-router demo-subnet
neutron router-gateway-set demo-router ext-net
