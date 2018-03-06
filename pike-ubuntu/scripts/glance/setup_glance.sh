#!/bin/bash
su -s /bin/sh -c "glance-manage db_sync" glance
service glance-registry restart && service glance-api restart
rm -f /var/lib/glance/glance.sqlite

source admin-openrc.sh
openstack image create "cirros" \
  --file cirros-0.3.5-x86_64-disk.img \
  --disk-format qcow2 --container-format bare \
  --public

openstack image list
