#!/bin/bash

docker stop s1
docker stop ha
docker stop s2
docker stop s3
declare -i fileNum=0
dest="/home/ryan/Desktop/logs/task-6/test-1"

# 0) Run the haProxy container
docker-compose up -d haproxy

docker cp ha:/usr/local/etc/haproxy/haproxy.cfg $dest
fileName="haproxy.cfg-"${fileNum}.txt
mv "${dest}"/haproxy.cfg "${dest}"/$fileName
fileNum=fileNum+1
echo $fileNum

sleep 5
# 1) Run the S1 container
docker-compose up -d webapp1

# Copy config file
docker cp ha:/usr/local/etc/haproxy/haproxy.cfg $dest
fileName="haproxy.cfg-"${fileNum}.txt
mv "${dest}"/haproxy.cfg "${dest}"/$fileName
fileNum=fileNum+1
echo $fileNum
 
# 2) Run the S2 container
docker-compose up -d webapp2

# Copy config file
docker cp ha:/usr/local/etc/haproxy/haproxy.cfg $dest
fileName="haproxy.cfg-"${fileNum}.txt
 
mv "${dest}"/haproxy.cfg "${dest}"/$fileName
fileNum=fileNum+1
echo $fileNum



sleep 3
docker cp ha:/nodes ${dest}/nodes/1

# 3) Run the S3 container
docker-compose up -d webapp3
sleep 5
docker cp ha:/usr/local/etc/haproxy/haproxy.cfg $dest
fileName="haproxy.cfg-"${fileNum}.txt
mv "${dest}"/haproxy.cfg "${dest}"/$fileName
fileNum=fileNum+1
echo $fileNum

docker ps > "${dest}"/ps.txt
docker inspect haproxy > "${dest}"/inspect-ha.txt
docker inspect s1 > "${dest}"/inspect-s1.txt
docker inspect s2 > "${dest}"/inspect-s2.txt
docker inspect s3 > "${dest}"/inspect-s3.txt
