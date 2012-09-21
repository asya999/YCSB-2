var config = {
    _id : "rs2",
    members : [
        {_id : "shard2", host : "ycsb-node1:27018"}
    ]
};

rs.initiate(config);

rs.slaveOk();

rs.status();