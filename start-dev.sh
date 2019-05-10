
docker-compose up -d

docker exec -it janus-dev_cassandra_1 sed -i 's/start_rpc: false/start_rpc: true/' /etc/cassandra/cassandra.yaml
docker restart janus-dev_cassandra_1

if [ ! -d "janusgraph-0.2.2-hadoop2" ]; then
  wget https://github.com/JanusGraph/janusgraph/releases/download/v0.2.2/janusgraph-0.2.2-hadoop2.zip
  unzip janusgraph-0.2.2-hadoop2.zip
  cd janusgraph-0.2.2-hadoop2
  sed -i "s/scriptEvaluationTimeout.*/scriptEvaluationTimeout: 180000/" conf/gremlin-server/gremlin-server-configuration.yaml
  ./bin/gremlin-server.sh conf/gremlin-server/gremlin-server-configuration.yaml
fi

