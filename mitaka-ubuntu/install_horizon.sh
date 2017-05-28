#!/bin/bash
source ~/admin-openrc.sh

apt-get install -y openstack-dashboard
sed -i '/^WSGIProcessGroup horizon/a WSGIApplicationGroup %{GLOBAL}' /etc/apache2/conf-enabled/openstack-dashboard.conf
