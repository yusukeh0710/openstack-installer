#!/bin/bash
su -s /bin/sh -c "cinder-manage db sync" cinder
rm -f /var/lib/cinder/cinder.sqlite
service cinder-scheduler restart && service cinder-api restart && service nova-api restart
service cinder-volume restart && service tgt restart

cinder type-create lvm
cinder type-key lvm set volume_backend_name=lvm
