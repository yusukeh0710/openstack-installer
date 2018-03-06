#!/bin/bash
USER_NAME=$1
PROJECT_NAME=$2
PASSWORD=$3

if [ -z "${USER_NAME}" ] || [ -z "${PROJECT_NAME}" ]; then
  echo "usage: $0 USER_NAME TENANT_NAME [ PASSWORD ]"
  exit 1
fi

if [ -z "${PASSWORD}" ]; then
  read -sp "Password: " PASSWORD
fi

cat <<EOS >./${USER_NAME}-openrc.sh
export OS_PROJECT_DOMAIN_NAME=default
export OS_USER_DOMAIN_NAME=default
export OS_PROJECT_NAME=${PROJECT_NAME}
export OS_USERNAME=${USER_NAME}
export OS_PASSWORD=${PASSWORD}
export OS_AUTH_URL=http://controller:35357/v3
export OS_IDENTITY_API_VERSION=3
export OS_IMAGE_API_VERSION=2
export PS1='\u@\h \W(${USER_NAME})\$ '
EOS
