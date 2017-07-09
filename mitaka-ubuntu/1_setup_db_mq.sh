#!/bin/bash
source openstack.ini

# OpenStack packages
apt-get install -y python-openstackclient

# SQL database
apt-get install -y mariadb-server python-pymysql

cat << EOS > /etc/mysql/conf.d/openstack.cnf
[mysqld]
bind-address = ${URL}
default-storage-engine = innodb
innodb_file_per_table
max_connections = 4096
collation-server = utf8_general_ci
character-set-server = utf8
EOS

service mysql restart

# Message queue
apt-get install -y rabbitmq-server

rabbitmqctl add_user openstack password
rabbitmqctl set_permissions openstack ".*" ".*" ".*"

service rabbitmq-server restart

# Install memcached
apt-get install -y memcached python-memcache
sed -i "s/-l 127.0.0.1/-l ${URL}/g" /etc/memcached.conf
service memcached restart

# Prepare RCfiles
OS_TOKEN=`openssl rand -hex 10`
cat <<EOS >~/keystonerc.sh
export OS_TOKEN=${OS_TOKEN}
export OS_URL=http://controller:35357/v3
export OS_IDENTITY_API_VERSION=3
EOS

cat <<EOS >~/admin-openrc.sh
export OS_PROJECT_DOMAIN_NAME=default
export OS_USER_DOMAIN_NAME=default
export OS_PROJECT_NAME=admin
export OS_USERNAME=admin
export OS_PASSWORD=password
export OS_AUTH_URL=http://controller:35357/v3
export OS_IDENTITY_API_VERSION=3
export OS_IMAGE_API_VERSION=2
export PS1='\u@\h \W(admin)\$ '
EOS

cat <<EOS >~/demo-openrc.sh
export OS_PROJECT_DOMAIN_NAME=default
export OS_USER_DOMAIN_NAME=default
export OS_PROJECT_NAME=demo
export OS_USERNAME=demo
export OS_PASSWORD=password
export OS_AUTH_URL=http://controller:5000/v3
export OS_IDENTITY_API_VERSION=3
export OS_IMAGE_API_VERSION=2
export PS1='\u@\h \W(demo)\$ '
EOS
