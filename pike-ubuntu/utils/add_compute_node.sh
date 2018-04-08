#!/bin/bash
source admin-openrc.sh
openstack compute service list
su -s /bin/sh -c "nova-manage cell_v2 discover_hosts --verbose" nova
