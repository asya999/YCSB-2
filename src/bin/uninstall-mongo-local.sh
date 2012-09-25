#!/bin/sh
killall -9 mongos mongod
rm -fr /usr/lib/mongodb
rm -fr /var/log/mongodb
rm -fr /data/*