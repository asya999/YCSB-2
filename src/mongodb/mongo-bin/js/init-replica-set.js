var config = {
    _id : "rs0",
    members : [
        {_id : 0, host : "ycsb-node1"},
        {_id : 1, host : "ycsb-node2"},
        {_id : 2, host : "ycsb-node3"},
        {_id : 3, host : "ycsb-node4"},
    ]
};

rs.initiate(config);

rs.slaveOk();

rs.status();