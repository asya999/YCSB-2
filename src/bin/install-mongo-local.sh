#!/bin/sh
BASE_DIR=`dirname $0`
. $BASE_DIR/mongo-env.sh

# Clean up
killall -9 mongos mongod
rm -fr /usr/lib/mongodb
rm -fr /var/log/mongodb
rm -fr /data

wget http://downloads.mongodb.org/linux/mongodb-linux-x86_64-${MONGO_VERSION}.tgz -P /tmp
tar xzf /tmp/mongodb-linux-x86_64-${MONGO_VERSION}.tgz -C /tmp
mv /tmp/mongodb-linux-x86_64-${MONGO_VERSION}/ /usr/lib/mongodb
rm /tmp/mongodb-linux-x86_64-${MONGO_VERSION}.tgz

hostname=`hostname`

case $hostname in
    ycsb-node1 )
        mongo-bin/start-mongod.sh -r rs1 -p 27017
        mongo-bin/start-mongod.sh -r rs2 -p 27018
        mongo-bin/start-mongod-configsvr.sh -p 27019
        mongo-bin/start-mongos.sh -p 27020 ;;
        $MONGO_HOME/bin/mongo $BASE_DIR/js/init-replica-set-rs1.js ;;
    ycsb-node2 )
        mongo-bin/start-mongod.sh -r rs2 -p 27017
        mongo-bin/start-mongod.sh -r rs1 -p 27018
        mongo-bin/start-mongos.sh -p 27020 ;;
        $MONGO_HOME/bin/mongo $BASE_DIR/js/init-replica-set-rs2.js ;;
    ycsb-node2 )
        mongo-bin/start-mongod.sh -r rs3 -p 27017
        mongo-bin/start-mongod.sh -r rs4 -p 27018
        mongo-bin/start-mongos.sh -p 27020 ;;
        $MONGO_HOME/bin/mongo $BASE_DIR/js/init-replica-set-rs3.js ;;
    ycsb-node2 )
        mongo-bin/start-mongod.sh -r rs4 -p 27017
        mongo-bin/start-mongod.sh -r rs3 -p 27018
        mongo-bin/start-mongos.sh -p 27020 ;;
        $MONGO_HOME/bin/mongo $BASE_DIR/js/init-replica-set-rs4.js ;;
esac
