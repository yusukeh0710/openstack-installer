#!/bin/bash
su -s /bin/sh -c "glance-manage db_sync" glance

service glance-registry restart
service glance-api restart

wget http://download.cirros-cloud.net/0.4.0/cirros-0.4.0-x86_64-disk.img
sleep 5

source admin-openrc.sh
openstack image create "cirros" \
  --file cirros-0.4.0-x86_64-disk.img \
  --disk-format qcow2 --container-format bare \
  --public

openstack image list
