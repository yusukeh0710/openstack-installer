#!/bin/bash
service glance-registry restart
service glance-api restart
exec /bin/bash
