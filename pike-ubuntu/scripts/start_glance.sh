#!/bin/bash
service glance-registry start
service glance-api start
exec /bin/bash
