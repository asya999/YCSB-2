#!/bin/bash
. mongo-env.sh

$MONGO_HOME/bin/mongo --quiet $MONGO_ROUTER/admin $BASE_DIR/js/init-sharding.js