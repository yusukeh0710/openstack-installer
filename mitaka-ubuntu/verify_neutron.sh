#!/bin/bash
source ~/admin-openrc.sh
neutron ext-list
neutron router-port-list demo-router -c fixed_ips

