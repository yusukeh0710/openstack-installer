#!/bin/bash
chown root:kvm /dev/kvm
chmod 660 /dev/kvm

service libvirtd start
service virtlogd start
service nova-compute start
service neutron-linuxbridge-agent start
exec /bin/bash
