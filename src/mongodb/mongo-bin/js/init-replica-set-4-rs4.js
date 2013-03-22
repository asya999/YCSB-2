var config = {
    _id : "rs4",
    members : [
        {_id : 0, host : "ycsb-node4:27018"},
        {_id : 1, host : "ycsb-node1:27019"}
    ]
};

rs.initiate(config);

rs.slaveOk();

rs.status();