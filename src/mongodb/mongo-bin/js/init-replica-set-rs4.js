var config = {
    _id : "rs4",
    members : [
        {_id : 0, host : "ycsb-node4:27017"},
        {_id : 1, host : "ycsb-node3:27018"}
    ]
};

rs.initiate(config);

rs.slaveOk();

rs.status();