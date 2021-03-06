#!/bin/bash
BIN_HOME=./../../bin

. $BIN_HOME/utils.sh
. ./workload-env.sh

workloads=("profile=cassandra-${CASSANDRA_VERSION}-f.workload target=0 operationcount=100000"

           "profile=cassandra-${CASSANDRA_VERSION}-f.workload target=100 operationcount=10000"
           "profile=cassandra-${CASSANDRA_VERSION}-f.workload target=300 operationcount=30000"
           "profile=cassandra-${CASSANDRA_VERSION}-f.workload target=500 operationcount=50000"
           "profile=cassandra-${CASSANDRA_VERSION}-f.workload target=800 operationcount=80000"
           "profile=cassandra-${CASSANDRA_VERSION}-f.workload target=1000 operationcount=100000"
           "profile=cassandra-${CASSANDRA_VERSION}-f.workload target=1200 operationcount=100000"
           "profile=cassandra-${CASSANDRA_VERSION}-f.workload target=1500 operationcount=100000"
           "profile=cassandra-${CASSANDRA_VERSION}-f.workload target=1800 operationcount=100000")

workloads=$(array_join "${workloads[@]}")

$BIN_HOME/run-workload.sh -w "$workloads"