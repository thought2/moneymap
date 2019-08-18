import { Elm } from "../elm/Main";
import dagre from "dagre";

const app = Elm.Main.init({
  node: document.getElementById("app"),
  flags: null
});

app.ports.setLayout.subscribe(({ nodes, edges }) => {
  var graph = new dagre.graphlib.Graph();

  nodes.forEach(({ id, data }) => {
    graph.setNode(id, data);
  });

  edges.forEach(({ from, to }) => {
    graph.setEdge(from, to);
  });

  dagre.layout(graph);

  app.ports.getLayout.send({
    nodes: graph.nodes().map(id => ({ id, data: graph.node(id) })),
    edges: graph
      .edges()
      .map(edge => ({ from: edge.v, to: edge.w, data: graph.edge(edge) }))
  });
});
