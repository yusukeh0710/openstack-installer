#!/bin/bash
source openstack.ini

docker build --tag openstack_base:latest -f dockerfiles/Dockerfile.base ./

docker build --build-arg CTRL_IP=${CTRL_IP} --tag openstack_db:setup -f dockerfiles/Dockerfile.db ./

docker build --tag openstack_mq:setup -f dockerfiles/Dockerfile.mq ./

docker build --build-arg LISTEN_IP=${CTRL_IP} --tag openstack_memcached:setup -f dockerfiles/Dockerfile.memcached ./

docker build --tag openstack_keystone:setup -f dockerfiles/Dockerfile.keystone ./

docker build --tag openstack_glance:setup -f dockerfiles/Dockerfile.glance ./

docker build --build-arg CTRL_IP=${CTRL_IP} \
             --build-arg INSTANCE_METADATA_SECRET=${INSTANCE_METADATA_SECRET} \
             --tag openstack_nova:setup -f dockerfiles/Dockerfile.nova ./

docker build --build-arg CTRL_IP=${CTRL_IP} --build-arg NEUTRON_IP=${NEUTRON_IP} \
             --build-arg NEUTRON_NIC=${NEUTRON_NIC} \
             --build-arg INSTANCE_METADATA_SECRET=${INSTANCE_METADATA_SECRET} \
             --tag openstack_neutron:setup -f dockerfiles/Dockerfile.neutron ./

docker build --tag openstack_horizon:setup -f dockerfiles/Dockerfile.horizon ./
