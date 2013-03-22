#!/bin/bash
. mongo-env.sh

hostname=`hostname`

case $hostname in
    ycsb-node1 )
        $MONGO_HOME/bin/mongo --quiet js/init-replica-set-4-rs1.js --port 27018;;
    ycsb-node2 )
        $MONGO_HOME/bin/mongo --quiet js/init-replica-set-4-rs2.js --port 27018;;
    ycsb-node3 )
        $MONGO_HOME/bin/mongo --quiet js/init-replica-set-4-rs3.js --port 27018;;
    ycsb-node4 )
        $MONGO_HOME/bin/mongo --quiet js/init-replica-set-4-rs4.js --port 27018;;
esac
