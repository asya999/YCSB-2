#!/bin/sh
BASE_DIR=`dirname $0`
. $BASE_DIR/mongo-env.sh

hostname=`hostname`

case $hostname in
    ycsb-node1 )
        $MONGO_HOME/bin/mongo $BASE_DIR/js/init-replica-set-rs1.js ;;
    ycsb-node2 )
        $MONGO_HOME/bin/mongo $BASE_DIR/js/init-replica-set-rs2.js ;;
    ycsb-node2 )
        $MONGO_HOME/bin/mongo $BASE_DIR/js/init-replica-set-rs3.js ;;
    ycsb-node2 )
        $MONGO_HOME/bin/mongo $BASE_DIR/js/init-replica-set-rs4.js ;;
esac
