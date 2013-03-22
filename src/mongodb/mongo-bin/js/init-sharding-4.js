var shards = [
    "rs1/ycsb-node1:27018,ycsb-node2:27019",
    "rs2/ycsb-node2:27018,ycsb-node3:27019",
    "rs3/ycsb-node3:27018,ycsb-node4:27019",
    "rs4/ycsb-node4:27018,ycsb-node1:27019",
];

for (var i = 0; i < shards.length; i++) {
    db.runCommand({
        addshard : shards[i]
    });
    }

db.runCommand({
    enablesharding : "UserDatabase"
});

db.runCommand({
    shardcollection : "UserDatabase.UserTable", key : { _id : 1 }
});

db.printShardingStatus();
