#!/bin/bash
service rabbitmq-server start
sleep 3

rabbitmqctl add_user openstack password
rabbitmqctl set_permissions openstack ".*" ".*" ".*"
service rabbitmq-server restart
