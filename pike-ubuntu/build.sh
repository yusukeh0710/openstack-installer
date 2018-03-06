#!/bin/bash
source openstack.ini

docker build --tag openstack_base:latest -f dockerfiles/Dockerfile.base ./

docker build --build-arg BASE_IP=${BASE_IP} --tag openstack_db:setup -f dockerfiles/Dockerfile.db ./

docker build --build-arg BASE_IP=${BASE_IP} --tag openstack_mq:setup -f dockerfiles/Dockerfile.mq ./

docker build --build-arg BASE_IP=${BASE_IP} --tag openstack_memcached:setup -f dockerfiles/Dockerfile.memcached ./

docker build --build-arg BASE_IP=${BASE_IP} --tag openstack_keystone:setup -f dockerfiles/Dockerfile.keystone ./

docker build --tag openstack_glance:setup -f dockerfiles/Dockerfile.glance ./
