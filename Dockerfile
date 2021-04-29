# start with couchbase
FROM couchbase/server:enterprise-6.0.0

MAINTAINER Kerim Yılmaz

COPY scripts/configure-node.sh /
COPY scripts/entrypoint.sh /

CMD ["couchbase-server"]

# 8091: Couchbase Web console, REST/HTTP interface
# 8092: Views, queries, XDCR
# 8093: Query services (4.0+)

EXPOSE 8091 8092 8093 
VOLUME /opt/couchbase/var
