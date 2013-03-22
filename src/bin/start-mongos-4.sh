#!/bin/bash
hostname=`hostname`

case $hostname in
    ycsb-node1 )
        mongo-bin/start-mongos.sh -c ycsb-node1:27017,ycsb-node2:27017,ycsb-node3:27017 -p 27020;;
    ycsb-node2 )
        mongo-bin/start-mongos.sh -c ycsb-node1:27017,ycsb-node2:27017,ycsb-node3:27017 -p 27020;;
    ycsb-node3 )
        mongo-bin/start-mongos.sh -c ycsb-node1:27017,ycsb-node2:27017,ycsb-node3:27017 -p 27020;;
    ycsb-node4 )
        mongo-bin/start-mongos.sh -c ycsb-node1:27017,ycsb-node2:27017,ycsb-node3:27017 -p 27020;;
esac
