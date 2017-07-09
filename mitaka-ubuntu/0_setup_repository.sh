#!/bin/bash
source openstack.ini

# OpenStack packages
apt-get install software-properties-common
add-apt-repository cloud-archive:mitaka
apt-get update && apt-get dist-upgrade

echo "Setup and Update repository information. Please reboot."
