#!/bin/bash
source compute.ini

docker run -d -it -h compute --name openstack-compute --restart=always \
       --net=host --pid=host --privileged \
       -v /dev:/dev -v /lib/modules:/lib/modules \
       --add-host=controller:${CTRL_IP} --add-host=compute:${COMPUTE_IP} \
       openstack_compute:setup
