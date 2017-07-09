#!/bin/bash
source openstack.ini 

# Configure database
mysql -u root --password=password << EOF
CREATE DATABASE keystone;
GRANT ALL PRIVILEGES ON keystone.* TO 'keystone'@'localhost' \
IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON keystone.* TO 'keystone'@'%' \
IDENTIFIED BY 'password';
EOF

# Install package
echo "manual" > /etc/init/keystone.override
apt-get install -y keystone apache2 libapache2-mod-wsgi
