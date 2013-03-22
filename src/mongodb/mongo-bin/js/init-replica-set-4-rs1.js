var config = {
    _id : "rs1",
    members : [
        {_id : 0, host : "ycsb-node1:27018"},
        {_id : 1, host : "ycsb-node2:27019"}
    ]
};

rs.initiate(config);

rs.slaveOk();

rs.status();