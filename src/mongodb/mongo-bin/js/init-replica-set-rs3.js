var config = {
    _id : "rs3",
    members : [
        {_id : "shard3", host : "ycsb-node4:27018"}
    ]
};

rs.initiate(config);

rs.slaveOk();

rs.status();