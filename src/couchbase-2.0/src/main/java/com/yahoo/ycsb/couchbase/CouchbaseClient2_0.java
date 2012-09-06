package com.yahoo.ycsb.couchbase;

import com.couchbase.client.CouchbaseClient;
import com.couchbase.client.CouchbaseConnectionFactory;
import com.couchbase.client.CouchbaseConnectionFactoryBuilder;
import com.yahoo.ycsb.ByteIterator;
import com.yahoo.ycsb.memcached.MemcachedCompatibleClient;
import com.yahoo.ycsb.memcached.MemcachedCompatibleConfig;
import com.yahoo.ycsb.workloads.RangeScanOperation;
import net.spy.memcached.MemcachedClient;

import java.net.URI;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;

@SuppressWarnings({"NullableProblems"})
public class CouchbaseClient2_0 extends MemcachedCompatibleClient implements RangeScanOperation {

    private CouchbaseConfig couchbaseConfig;

    @Override
    protected MemcachedCompatibleConfig createMemcachedConfig() {
        return couchbaseConfig = new CouchbaseConfig(getProperties());
    }

    @Override
    protected MemcachedClient createMemcachedClient() throws Exception {
        return createCouchbaseClient();
    }

    protected CouchbaseClient createCouchbaseClient() throws Exception {
        CouchbaseConnectionFactoryBuilder builder = new CouchbaseConnectionFactoryBuilder();
        builder.setReadBufferSize(config.getReadBufferSize());
        builder.setOpTimeout(config.getOpTimeout());
        builder.setFailureMode(config.getFailureMode());

        List<URI> servers = new ArrayList<URI>();
        for (String address : config.getHosts().split(",")) {
            servers.add(new URI("http://" + address + ":8091/pools"));
        }
        CouchbaseConnectionFactory connectionFactory =
                builder.buildCouchbaseConnection(servers,
                        couchbaseConfig.getBucket(), couchbaseConfig.getUser(), couchbaseConfig.getPassword());
        return new com.couchbase.client.CouchbaseClient(connectionFactory);
    }

    @Override
    public int scan(String table, String startKey, int limit, Set<String> fields, List<Map<String, ByteIterator>> result) {
        throw new UnsupportedOperationException("Scan not implemented");
    }

    @Override
    public int scan(String table, String startKey, String endKey, int limit, Set<String> fields, List<Map<String, ByteIterator>> result) {
        throw new UnsupportedOperationException("Scan not implemented");
    }
}
