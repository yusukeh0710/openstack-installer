#!/bin/bash
USER=$1
PASS=$2
SERVICE=$3
DESC=$4
INTERNAL_URL=$5
ADMIN_URL=$6

if [ -z "${USER}" ] || [ -z "${PASS}" ] || [ -z "${SERVICE}" ] || [ -z "${DESC}" ] || [ -z "${INTERNAL_URL}" ]; then
  echo "usage: $0 USER_NAME PASSWORD SERVICE DESCRIPTION INTERNAL_URL [ ADMIN_URL ]"
  exit 1
fi

if [ -z "${ADMIN_URL}" ]; then
  ADMIN_URL=${INTERNAL_URL}
fi

source admin-openrc.sh
openstack user create --domain default --password ${PASS} ${USER}
openstack role add --project service --user ${USER} admin

openstack service create --name ${USER} --description "${DESC}" ${SERVICE}
openstack endpoint create --region RegionOne ${SERVICE} public ${INTERNAL_URL}
openstack endpoint create --region RegionOne ${SERVICE} internal ${INTERNAL_URL}
openstack endpoint create --region RegionOne ${SERVICE} admin ${ADMIN_URL}
