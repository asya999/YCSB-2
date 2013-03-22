#!/bin/bash
. mongo-env.sh

hostname=`hostname`

case $hostname in
    ycsb-node1 )
        $MONGO_HOME/bin/mongo --quiet js/init-replica-set-4-rs1.js ;;
    ycsb-node2 )
        $MONGO_HOME/bin/mongo --quiet js/init-replica-set-4-rs2.js ;;
    ycsb-node3 )
        $MONGO_HOME/bin/mongo --quiet js/init-replica-set-4-rs3.js ;;
    ycsb-node4 )
        $MONGO_HOME/bin/mongo --quiet js/init-replica-set-4-rs4.js ;;
esac
