#!/bin/bash
source ~/admin-openrc.sh

wget http://download.cirros-cloud.net/0.3.4/cirros-0.3.4-x86_64-disk.img
glance image-create --name "cirros-0.3.4-x86_64" \
 --file cirros-0.3.4-x86_64-disk.img --disk-format qcow2 \
 --container-format bare \
 --visibility public --progress
