#!/bin/bash
rabbitmqctl add_user openstack password
rabbitmqctl set_permissions openstack ".*" ".*" ".*"
service rabbitmq-server restart
