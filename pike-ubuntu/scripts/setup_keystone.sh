#!/bin/bash
su -s /bin/sh -c "keystone-manage db_sync" keystone

source admin-openrc.sh
keystone-manage fernet_setup --keystone-user keystone \
  --keystone-group keystone

keystone-manage credential_setup --keystone-user keystone \
  --keystone-group keystone

keystone-manage bootstrap --bootstrap-password password \
  --bootstrap-admin-url http://controller:35357/v3/ \
  --bootstrap-internal-url http://controller:35357/v3/ \
  --bootstrap-public-url http://controller:5000/v3/ \
  --bootstrap-region-id RegionOne

service apache2 restart

rm /var/lib/keystone/keystone.db -f

openstack project create --domain default --description "Service Project" service
openstack project create --domain default --description "Demo Project" demo
openstack user create --domain default --password password demo
openstack role create user
openstack role add --project demo --user demo user
