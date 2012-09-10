package com.yahoo.ycsb.couchbase;

import com.couchbase.client.CouchbaseClient;
import com.couchbase.client.protocol.views.View;
import com.couchbase.client.protocol.views.Query;
import com.couchbase.client.protocol.views.ViewResponse;
import com.couchbase.client.CouchbaseConnectionFactory;
import com.couchbase.client.CouchbaseConnectionFactoryBuilder;
import com.yahoo.ycsb.memcached.MemcachedCompatibleClient;
import com.yahoo.ycsb.memcached.MemcachedCompatibleConfig;
import net.spy.memcached.MemcachedClient;

import java.net.URI;
import java.util.ArrayList;
import java.util.List;
import java.util.Collection;

@SuppressWarnings({"NullableProblems"})
public class CouchbaseClient2_0 extends MemcachedCompatibleClient {

    protected CouchbaseClient client;

    private CouchbaseConfig couchbaseConfig;

    private static String DDOC_NAME = "ddoc";
    private static String VIEW_NAME = "view";

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
    public int query(String table, String key, int limit) {
        key = createQualifiedKey(table, key);

        Query query = new Query();
        query.setKey(key);
        query.setLimit(limit);
        ViewResponse response = client.query(get_view(), query);

        Collection errors = response.getErrors();
        if (errors.isEmpty() == true) {
            return 0;
        } else {
            return 1;
        }
    };

    private View get_view() {
        View view = client.getView(DDOC_NAME, VIEW_NAME);
        return  view;
    }
}
