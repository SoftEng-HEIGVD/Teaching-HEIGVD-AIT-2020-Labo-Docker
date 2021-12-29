#!/bin/bash

declare -i fileNum=0
dest="/home/ryan/Desktop/logs/task-5"
docker-compose up -d haproxy
 docker cp ha:/usr/local/etc/haproxy/haproxy.cfg $dest
 fileName="haproxy.cfg-"${fileNum}.txt
 
mv "${dest}"/haproxy.cfg "${dest}"/$fileName
 
 fileNum=fileNum+1
 echo $fileNum
# 1) Run the S1 container
docker-compose up -d webapp1



# Copy config file
 docker cp ha:/usr/local/etc/haproxy/haproxy.cfg $dest
 fileName="haproxy.cfg-"${fileNum}.txt
 
mv "${dest}"/haproxy.cfg "${dest}"/$fileName
 
 fileNum=fileNum+1
 echo $fileNum
# 5) Run the S2 container
docker-compose up -d webapp2

# Copy config file
docker cp ha:/usr/local/etc/haproxy/haproxy.cfg $dest
fileName="haproxy.cfg-"${fileNum}.txt
 
mv "${dest}"/haproxy.cfg "${dest}"/$fileName
 fileNum=fileNum+1
 echo $fileNum

docker ps > "${dest}"/ps.txt
docker inspect haproxy > "${dest}"/inspect-ha.txt
docker inspect s1 > "${dest}"/inspect-s1.txt
docker inspect s2 > "${dest}"/inspect-s2.txt

sleep 3
docker cp ha:/nodes ${dest}/nodes/1

docker stop s1
sleep 5
# Copy config file
docker cp ha:/usr/local/etc/haproxy/haproxy.cfg $dest
fileName="haproxy.cfg-"${fileNum}.txt
 
mv "${dest}"/haproxy.cfg "${dest}"/$fileName
docker ps > "${dest}"/psStop.txt
docker cp ha:/nodes ${dest}/nodes/2
