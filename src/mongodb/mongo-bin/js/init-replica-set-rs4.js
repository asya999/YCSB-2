var config = {
    _id : "rs4",
    members : [
        {_id : "shard4", host : "ycsb-node3:27018"}
    ]
};

rs.initiate(config);

rs.slaveOk();

rs.status();