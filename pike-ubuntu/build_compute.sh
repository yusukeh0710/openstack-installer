#!/bin/bash
source compute.ini

docker build --tag openstack_base:latest -f dockerfiles/Dockerfile.base ./

docker build --build-arg CTRL_IP=${CTRL_IP} \
             --build-arg COMPUTE_IP=${COMPUTE_IP} --build-arg COMPUTE_NIC=${COMPUTE_NIC} \
             --tag openstack_compute:setup -f dockerfiles/Dockerfile.compute ./
