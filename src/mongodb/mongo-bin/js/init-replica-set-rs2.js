var config = {
    _id : "rs2",
    members : [
        {_id : 0, host : "ycsb-node3:27017"},
        {_id : 1, host : "ycsb-node4:27017"}
    ]
};

rs.initiate(config);

rs.slaveOk();

rs.status();