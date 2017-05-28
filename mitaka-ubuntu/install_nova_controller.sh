#!/bin/bash
source ~/admin-openrc.sh

# Configure daatabase
mysql -u root --password=password << EOF
CREATE DATABASE nova_api;
CREATE DATABASE nova;
GRANT ALL PRIVILEGES ON nova_api.* TO 'nova'@'localhost' \
IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON nova_api.* TO 'nova'@'%' \
IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON nova.* TO 'nova'@'localhost' \
IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON nova.* TO 'nova'@'%' \
IDENTIFIED BY 'password';
EOF

# Configure keystone
openstack user create --domain default --password password nova
openstack role add --project service --user nova admin
openstack service create --name nova --description "OpenStack Compute" compute

openstack endpoint create --region RegionOne compute public http://controller:8774/v2.1/%\(tenant_id\)s
openstack endpoint create --region RegionOne compute internal http://controller:8774/v2.1/%\(tenant_id\)s
openstack endpoint create --region RegionOne compute admin http://controller:8774/v2.1/%\(tenant_id\)s

# Install package
apt-get install -y nova-api nova-conductor nova-consoleauth nova-novncproxy nova-scheduler
