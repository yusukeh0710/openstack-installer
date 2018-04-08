#!/bin/bash
service apache2 start
service nova-api start
service nova-consoleauth start
service nova-scheduler start
service nova-conductor start
service nova-novncproxy start
exec /bin/bash
