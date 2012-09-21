var config = {
    _id : "rs1",
    members : [
        {_id : "shard1", host : "ycsb-node2:27018"}
    ]
};

rs.initiate(config);

rs.slaveOk();

rs.status();