#!/bin/bash
source ~/admin-openrc.sh

su -s /bin/sh -c "nova-manage api_db sync" nova
su -s /bin/sh -c "nova-manage db sync" nova

service nova-api restart && service nova-consoleauth restart && service nova-scheduler restart && \
service nova-conductor restart && service nova-novncproxy restart
rm -f /var/lib/nova/nova.sqlite
