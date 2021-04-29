#!/bin/bash

: ${DOCKER:=docker}
: ${COUCHBASE_NETWORK:=bridge}
: ${COUCHBASE_NODE_NAME:=couchbase-node}
: ${COUCHBASE_NODE_COUNT:=2}
: ${COUCHBASE_CLUSTER_NAME:=My Couchbase Cluster}
: ${COUCHBASE_BUCKET:=ecommerce}
: ${COUCHBASE_ADMINISTRATOR_USERNAME:Administrator}
: ${COUCHBASE_ADMINISTRATOR_PASSWORD:somepassword}
: ${COUCHBASE_RBAC_USERNAME:Please supply an RBAC username}
: ${COUCHBASE_RBAC_PASSWORD:Please supply an RBAC password}
: ${COUCHBASE_RBAC_NAME:=}
: ${COUCHBASE_RBAC_ROLES:="bucket_admin[*]"}
: ${COUCHBASE_SERVICES:="data"}
: ${COUCHBASE_SERVER_PORTS:="8091-8094:8091-8094::11210:11210"}

# Add nodes
docker_ip() {
  "$DOCKER" inspect --format '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' "$@"
}

for ((node = 5; node < $COUCHBASE_NODE_COUNT+5; ++node))
do  

  echo "Starting node ${COUCHBASE_NODE_NAME}_${node}"
  let offset=${node}*1000 || true
  ports=$(awk -v offset=$offset "$ports_script" <<< "${COUCHBASE_SERVER_PORTS}")
  "$DOCKER" run -d --name "${COUCHBASE_NODE_NAME}_${node}" --network "$COUCHBASE_NETWORK"  $ports couchbase:community-6.0.0



  "$DOCKER" exec "${COUCHBASE_NODE_NAME}_${node}" couchbase-cli server-add \
    --cluster couchbase://$(docker_ip "${COUCHBASE_NODE_NAME}1") \
    --username "$COUCHBASE_ADMINISTRATOR_USERNAME" \
	--password "$COUCHBASE_ADMINISTRATOR_PASSWORD" \
    --server-add $(docker_ip "${COUCHBASE_NODE_NAME}_${node}"):8091 \
    --server-add-username "$COUCHBASE_ADMINISTRATOR_USERNAME"\
	--server-add-password "$COUCHBASE_ADMINISTRATOR_PASSWORD" \
    --services "$COUCHBASE_SERVICES"
done
