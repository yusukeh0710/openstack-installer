#!/bin/bash
for d in $(docker ps -aq); do
  docker rm $d -f
done

for d in $(docker images | grep none  | awk '{print $3}'); do
  docker rmi $d -f
done
