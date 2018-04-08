#!/bin/bash
service neutron-server start
service neutron-linuxbridge-agent start
service neutron-dhcp-agent start
service neutron-metadata-agent start
service neutron-l3-agent start
exec /bin/bash
