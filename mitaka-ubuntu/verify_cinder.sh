#!/bin/bash
source ~/admin-openrc.sh
cinder service list
openstack volume create --size 1 volume
cinder list
