var shards = [
    "rs1/ycsb-node1:27017,ycsb-node2:27017",
    "rs2/ycsb-node3:27017,ycsb-node4:27017",
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
