:remote connect tinkerpop.server conf/remote.yaml session
:remote console
map = new HashMap<String, Object>();
map.put("storage.backend", "cassandrathrift");
map.put("storage.hostname", "127.0.0.1");
map.put("graph.graphname", "airroutes");
ConfiguredGraphFactory.createConfiguration(new MapConfiguration(map));

graph=ConfiguredGraphFactory.open("airroutes");

graph.io(graphml()).readGraph('./air-routes.graphml');

graph.tx().commit();

g=graph.traversal();
:set max-iteration 1000 