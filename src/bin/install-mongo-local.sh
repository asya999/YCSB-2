#!/bin/sh
MONGO_VERSION=2.2.0

wget http://downloads.mongodb.org/linux/mongodb-linux-x86_64-${MONGO_VERSION}.tgz -P /tmp
tar xzf /tmp/mongodb-linux-x86_64-${MONGO_VERSION}.tgz -C /tmp
mv /tmp/mongodb-linux-x86_64-${MONGO_VERSION}/ /usr/lib/mongodb
rm /tmp/mongodb-linux-x86_64-${MONGO_VERSION}.tgz

killall -9 mongos mongod
mongo-bin/start-mongod.sh
mongo-bin/start-mongod-configsvr.sh
mongo-bin/start-mongos.sh
