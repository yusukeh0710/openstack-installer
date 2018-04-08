#!/bin/bash
DATABASE=$1
USER=$2
PASS=$3

if [ -z "${DATABASE}" ] || [ -z "${USER}" ] || [ -z "${PASS}" ]; then
  echo "usage: $0 USER PASS"
  exit 1
fi

mysql -u root --password=password << EOF
CREATE DATABASE ${DATABASE};
GRANT ALL PRIVILEGES ON ${DATABASE}.* TO '${USER}'@'localhost' \
IDENTIFIED BY '${PASS}';
GRANT ALL PRIVILEGES ON ${DATABASE}.* TO '${USER}'@'%' \
IDENTIFIED BY '${PASS}';
EOF
