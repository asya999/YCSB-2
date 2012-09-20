#!/bin/sh
MONGO_VERSION=2.2.0

# Clean up
killall -9 mongos mongod
rm -fr /usr/lib/mongodb
rm -fr /var/log/mongodb
rm -fr /data

wget http://downloads.mongodb.org/linux/mongodb-linux-x86_64-${MONGO_VERSION}.tgz -P /tmp
tar xzf /tmp/mongodb-linux-x86_64-${MONGO_VERSION}.tgz -C /tmp
mv /tmp/mongodb-linux-x86_64-${MONGO_VERSION}/ /usr/lib/mongodb
rm /tmp/mongodb-linux-x86_64-${MONGO_VERSION}.tgz

mongo-bin/start-mongod.sh -r rs0
mongo-bin/start-mongod-configsvr.sh
mongo-bin/start-mongos.sh
