function ProgressBar {
  local duration=${1}


    already_done() { for ((done=0; done<$elapsed; done++)); do printf "▇"; done }
    remaining() { for ((remain=$elapsed; remain<$duration; remain++)); do printf " "; done }
    percentage() { printf "| %s%%" $(( (($elapsed)*100)/($duration)*100/100 )); }
    clean_line() { printf "\r"; }

  for (( elapsed=1; elapsed<=$duration; elapsed++ )); do
      already_done; remaining; percentage
      sleep 1
      clean_line
  done
  clean_line
}


docker-compose up -d

echo "Waiting for Cassandra/Elastic to start up..."
ProgressBar 120
echo " "
echo "Enable Thrift on Cassandra..."
docker exec -it janus-dev_cassandra_1  nodetool enablethrift

if [ ! -d "janusgraph-0.2.2-hadoop2" ]; then
  echo "Installing Janus Gremnlin Server"
  wget https://github.com/JanusGraph/janusgraph/releases/download/v0.2.2/janusgraph-0.2.2-hadoop2.zip
  unzip janusgraph-0.2.2-hadoop2.zip
  cd janusgraph-0.2.2-hadoop2
  rm -rf conf/gremlin-server/gremlin-server-configuration.yaml
  cp ../gremlin-server-configuration.yaml conf/gremlin-server/
  ./bin/gremlin-server.sh conf/gremlin-server/gremlin-server-configuration.yaml
else
    cd janusgraph-0.2.2-hadoop2
   ./bin/gremlin-server.sh conf/gremlin-server/gremlin-server-configuration.yaml
fi

