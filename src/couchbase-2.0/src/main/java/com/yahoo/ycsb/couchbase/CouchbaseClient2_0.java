package com.yahoo.ycsb.couchbase;

import com.couchbase.client.CouchbaseClient;
import com.couchbase.client.protocol.views.View;
import com.couchbase.client.protocol.views.Query;
import com.couchbase.client.protocol.views.ViewResponse;
import com.couchbase.client.CouchbaseConnectionFactory;
import com.couchbase.client.CouchbaseConnectionFactoryBuilder;
import com.yahoo.ycsb.ByteIterator;
import com.yahoo.ycsb.DBException;
import com.yahoo.ycsb.memcached.MemcachedCompatibleClient;
import net.spy.memcached.internal.GetFuture;
import net.spy.memcached.internal.OperationFuture;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.net.URI;
import java.util.*;

@SuppressWarnings({"NullableProblems"})
public class CouchbaseClient2_0 extends MemcachedCompatibleClient {
    protected final Logger log = LoggerFactory.getLogger(getClass());

    protected CouchbaseClient client;

    protected CouchbaseConfig couchbaseConfig;

    private static View view;

    private boolean checkOperationStatus;

    private long shutdownTimeoutMillis;

    private int objectExpirationTime;

    private Random generator = new Random();

    private Map<String, View> views = new HashMap<String, View>();

    private String[] ddoc_names;

    private String[] view_names;

    @Override
    public void init() throws DBException {
        try {
            couchbaseConfig = createMemcachedConfig();
            client = createMemcachedClient();
            checkOperationStatus = couchbaseConfig.getCheckOperationStatus();
            objectExpirationTime = couchbaseConfig.getObjectExpirationTime();
            shutdownTimeoutMillis = couchbaseConfig.getShutdownTimeoutMillis();
            ddoc_names = couchbaseConfig.getDdocs();
            view_names = couchbaseConfig.getViews();
        } catch (Exception e) {
            throw new DBException(e);
        }
    }

    protected CouchbaseConfig createMemcachedConfig() {
        return new CouchbaseConfig(getProperties());
    }

    protected CouchbaseClient createMemcachedClient() throws Exception {
        return createCouchbaseClient();
    }

    protected CouchbaseClient createCouchbaseClient() throws Exception {
        CouchbaseConnectionFactoryBuilder builder = new CouchbaseConnectionFactoryBuilder();
        builder.setReadBufferSize(couchbaseConfig.getReadBufferSize());
        builder.setOpTimeout(couchbaseConfig.getOpTimeout());
        builder.setFailureMode(couchbaseConfig.getFailureMode());

        List<URI> servers = new ArrayList<URI>();
        for (String address : couchbaseConfig.getHosts().split(",")) {
            servers.add(new URI("http://" + address + ":8091/pools"));
        }
        CouchbaseConnectionFactory connectionFactory =
                builder.buildCouchbaseConnection(servers,
                        couchbaseConfig.getBucket(), couchbaseConfig.getUser(), couchbaseConfig.getPassword());
        return new com.couchbase.client.CouchbaseClient(connectionFactory);
    }

    @Override
    public int read(String table, String key, Set<String> fields, Map<String, ByteIterator> result) {
        key = createQualifiedKey(table, key);
        try {
            GetFuture<Object> future =  client.asyncGet(key);
            return getReturnCode(future);
        } catch (Exception e) {
            if (log.isErrorEnabled()) {
                log.error("Error encountered", e);
            }
            return ERROR;
        }
    }

    protected int getReturnCode(GetFuture<Object> future) {
        if (checkOperationStatus) {
            return future.getStatus().isSuccess() ? OK : ERROR;
        } else {
            return OK;
        }
    }

    @Override
    public int update(String table, String key, Map<String, ByteIterator> values) {
        key = createQualifiedKey(table, key);
        try {
            OperationFuture<Boolean> future = client.replace(key, objectExpirationTime, toJson(values));
            return getReturnCode(future);
        } catch (Exception e) {
            if (log.isErrorEnabled()) {
                log.error("Error updating value with key: " + key, e);
            }
            return ERROR;
        }
    }

    @Override
    public int insert(String table, String key, Map<String, ByteIterator> values) {
        key = createQualifiedKey(table, key);
        try {
            OperationFuture<Boolean> future = client.add(key, objectExpirationTime, toJson(values));
            return getReturnCode(future);
        } catch (Exception e) {
            if (log.isErrorEnabled()) {
                log.error("Error inserting value", e);
            }
            return ERROR;
        }
    }

    @Override
    public int delete(String table, String key) {
        key = createQualifiedKey(table, key);
        try {
            OperationFuture<Boolean> future = client.delete(key);
            return getReturnCode(future);
        } catch (Exception e) {
            if (log.isErrorEnabled()) {
                log.error("Error deleting value", e);
            }
            return ERROR;
        }
    }

    @Override
    public int query(String table, String key, int limit) {
        key = createQualifiedKey(table, key);
        ViewResponse response = client.query(get_view(), get_query(key, limit));

        Collection errors = response.getErrors();
        if (errors.isEmpty() == true) {
            return 0;
        } else {
            return 1;
        }
    };

    private View get_view() {
        int rnd_ddoc = generator.nextInt(ddoc_names.length);
        int rnd_view = generator.nextInt(view_names.length);

        String ddoc_name = ddoc_names[rnd_ddoc];
        String view_name = view_names[rnd_view];
        String id = ddoc_name + view_name;

        if (views.get(id) == null) {
            view = client.getView(ddoc_name, view_name);
            views.put(id, view);
        }

        return  view;
    }

    private Query get_query(String key, int limit) {
        Query query = new Query();
        query.setStartkeyDocID(key);
        query.setLimit(limit);
        return query;
    }
}
