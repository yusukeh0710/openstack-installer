#!/bin/bash
su -s /bin/sh -c "glance-manage db_sync" glance
service glance-registry restart && service glance-api restart
rm -f /var/lib/glance/glance.sqlite


