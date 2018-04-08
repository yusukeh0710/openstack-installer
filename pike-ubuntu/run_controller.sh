#!/bin/bash
source openstack.ini
readonly HOST_OPTION="--add-host=controller:${CTRL_IP}"

RUN() {
  name=$1
  args=${@:2}

  if [ -z "${name}" ]; then
    echo "function (RUN) usage: NAME [ ARG1, ... ]"
    exit 1
  fi

  echo -e "\nRUN ${name} ..."
  docker run -d -it -h controller --name ${name} --restart=always ${args} openstack_${name}:setup
}

RUN_SETUP() {
  name=$1
  args=${@:2}
  RUN $@
  sleep 5
  docker exec ${name} /root/setup_${name}.sh
}

# Database
RUN db "--net=host"

# Message Queue
RUN_SETUP mq "--net=host"

# Memcached
RUN memcached "--net=host"

# Keystone
echo -e "\nPrepare Keystone ..."
docker exec db /root/add_db_user.sh keystone keystone password
RUN_SETUP keystone "${HOST_OPTION} -p 5000:5000 -p 35357:35357"

# Glance
echo -e "\nPrepare Glance ..."
docker exec db /root/add_db_user.sh glance glance password
docker exec keystone /root/add_keystone_user.sh \
  glance password image "OpenStack Image" http://controller:9292
RUN_SETUP glance "${HOST_OPTION} -p 9292:9292"

# Nova
echo -e "\nPrepare Nova ..."
docker exec db /root/add_db_user.sh nova_api nova password
docker exec db /root/add_db_user.sh nova nova password
docker exec db /root/add_db_user.sh nova_cell0 nova password
docker exec keystone /root/add_keystone_user.sh \
  nova password compute "OpenStack Compute" http://controller:8774/v2.1
docker exec keystone /root/add_keystone_user.sh \
  placement password placement "Placement API" http://controller:8778
RUN_SETUP nova "${HOST_OPTION} -p 6080:6080 -p 8774:8774 -p 8775:8775 -p 8778:8778"

# Neutron
echo -e "\nPrepare Neutron ..."
docker exec db /root/add_db_user.sh neutron neutron password
docker exec keystone /root/add_keystone_user.sh \
  neutron password network "OpenStack Networking" http://controller:9696
RUN_SETUP neutron "--net=host --pid=host --privileged -v /dev:/dev -v /lib/modules:/lib/modules" 

echo "Update Neutron section in Nova ..."
docker exec nova sed  -i '/^\[neutron\]/r /etc/nova/neutron.txt' /etc/nova/nova.conf
docker exec nova service nova-api restart

# Horizon
RUN horizon "--net=host"
