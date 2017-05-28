#!/bin/bash
source ~/admin-openrc.sh

# Configure database
mysql -u root --password=password << EOF
CREATE DATABASE glance;
GRANT ALL PRIVILEGES ON glance.* TO 'glance'@'localhost' \
 IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON glance.* TO 'glance'@'%' \
IDENTIFIED BY 'password';
EOF

# Configure keystone
openstack user create --domain default --password password glance
openstack role add --project service --user glance admin

openstack service create --name glance --description "OpenStack Image service" image
openstack endpoint create --region RegionOne image public http://controller:9292
openstack endpoint create --region RegionOne image internal http://controller:9292
openstack endpoint create --region RegionOne image admin http://controller:9292

# Install package
apt-get install -y glance
