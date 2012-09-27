#!/bin/bash
. mongo-env.sh

hostname=`hostname`

case $hostname in
    ycsb-node1 )
        $MONGO_HOME/bin/mongo --quiet js/init-replica-set-rs1.js ;;
    ycsb-node3 )
        $MONGO_HOME/bin/mongo --quiet js/init-replica-set-rs2.js ;;
esac
