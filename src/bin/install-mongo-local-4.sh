#!/bin/bash
MONGO_VERSION=2.2.3

wget http://downloads.mongodb.org/linux/mongodb-linux-x86_64-${MONGO_VERSION}.tgz -P /tmp
tar xzf /tmp/mongodb-linux-x86_64-${MONGO_VERSION}.tgz -C /tmp
mv -f /tmp/mongodb-linux-x86_64-${MONGO_VERSION}/ /usr/lib/mongodb
rm -f /tmp/mongodb-linux-x86_64-${MONGO_VERSION}.tgz

hostname=`hostname`

case $hostname in
    ycsb-node1 )
        mongo-bin/start-mongod.sh -r rs1 -p 27018 -d /data
        mongo-bin/start-mongod.sh -r rs4 -p 27019 -d /data1
        mongo-bin/start-mongod-configsvr.sh -p 27017
    ycsb-node2 )
        mongo-bin/start-mongod.sh -r rs2 -p 27018 -d /data
        mongo-bin/start-mongod.sh -r rs1 -p 27019 -d /data1
        mongo-bin/start-mongod-configsvr.sh -p 27017
    ycsb-node3 )
        mongo-bin/start-mongod.sh -r rs3 -p 27018 -d /data
        mongo-bin/start-mongod.sh -r rs2 -p 27019 -d /data1
        mongo-bin/start-mongod-configsvr.sh -p 27017
    ycsb-node4 )
        mongo-bin/start-mongod.sh -r rs4 -p 27018 -d /data
        mongo-bin/start-mongod.sh -r rs3 -p 27019 -d /data1
esac
