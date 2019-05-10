docker run --name jg-cassandra -d -e CASSANDRA_START_RPC=true -p 9160:9160 -p 9042:9042 -p 7199:7199 -p 7001:7001 -p 7000:7000 cassandra:3.11
docker exec -it jg-cassandra sed -i 's/start_rpc: false/start_rpc: true/' /etc/cassandra/cassandra.yaml
docker restart jg-cassandra

docker run -d -p 9200:9200 -p 9300:9300 -e "discovery.type=single-node" docker.elastic.co/elasticsearch/elasticsearch:7.0.1


wget https://github.com/JanusGraph/janusgraph/releases/download/v0.2.2/janusgraph-0.2.2-hadoop2.zip
unzip janusgraph-0.2.2-hadoop2.zip
cd janusgraph-0.2.2-hadoop2
sed -i "s/scriptEvaluationTimeout.*/scriptEvaluationTimeout: 180000/" conf/gremlin-server/gremlin-server-configuration.yaml
./bin/gremlin-server.sh conf/gremlin-server/gremlin-server-configuration.yaml