#!/bin/bash
source openstack.ini

RUN() {
  name=$1
  args=${@:2}

  if [ -z "${name}" ]; then
    echo "function (RUN) usage: NAME [ ARG1, ... ]"
    exit 1
  fi

  echo "RUN ${name} ..."
  docker run -d -it --name ${name} --net=host --pid=host ${args} openstack_${name}:setup
}

RUN_SETUP() {
  name=$1
  args=${@:2}
  RUN $@
  sleep 5
  docker exec ${name} /root/setup_${name}.sh
}

# Database
RUN db

# Message Queue
RUN_SETUP mq

# Memcached
RUN memcached

# Keystone
docker exec db /root/add_db_user.sh keystone keystone password
RUN_SETUP keystone "--add-host=controller:${BASE_IP}"

# Glance
docker exec db /root/add_db_user.sh glance glance password
docker exec keystone /root/add_keystone_user.sh \
  glance password image "OpenStack Image" http://controller:9292
RUN_SETUP glance "--add-host=controller:${BASE_IP}"
