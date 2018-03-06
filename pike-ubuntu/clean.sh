#!/bin/bash
for d in $(docker ps -a  | awk 'NR>1 {print $1}'); do
  docker rm -f $d
done

for i in $(docker images  | grep none | awk '{print $3}'); do
  docker rmi -f $i
done

