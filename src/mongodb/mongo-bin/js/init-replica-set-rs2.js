var config = {
    _id : "rs2",
    members : [
        {_id : 0, host : "ycsb-node2:27017"},
        {_id : 1, host : "ycsb-node1:27018"}
    ]
};

rs.initiate(config);

rs.slaveOk();

rs.status();