#!/bin/bash
MONGO_VERSION=2.2.3

wget http://downloads.mongodb.org/linux/mongodb-linux-x86_64-${MONGO_VERSION}.tgz -P /tmp
tar xzf /tmp/mongodb-linux-x86_64-${MONGO_VERSION}.tgz -C /tmp
mv -f /tmp/mongodb-linux-x86_64-${MONGO_VERSION}/ /usr/lib/mongodb
rm -f /tmp/mongodb-linux-x86_64-${MONGO_VERSION}.tgz

hostname=`hostname`

case $hostname in
    ycsb-node1 )
        mongo-bin/start-mongod.sh -r rs1 -p 27017
        mongo-bin/start-mongod-configsvr.sh -p 27019
        mongo-bin/start-mongos.sh -p 27020 ;;
    ycsb-node2 )
        mongo-bin/start-mongod.sh -r rs1 -p 27017
        mongo-bin/start-mongos.sh -p 27020 ;;
    ycsb-node3 )
        mongo-bin/start-mongod.sh -r rs2 -p 27017
        mongo-bin/start-mongos.sh -p 27020 ;;
    ycsb-node4 )
        mongo-bin/start-mongod.sh -r rs2 -p 27017
        mongo-bin/start-mongos.sh -p 27020 ;;
esac
