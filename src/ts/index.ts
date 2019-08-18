import { Elm } from "../elm/Main";
import dagre, { Edge } from "dagre";

const app = Elm.Main.init({
  node: document.getElementById("app"),
  flags: null
});

app.ports.setLayout.subscribe(({ nodes, edges }) => {
  var graph = new dagre.graphlib.Graph();

  nodes.forEach(({ id, label }) => {
    graph.setNode(id.toString(), label);
  });

  edges.forEach(({ from, to, label }) => {
    graph.setEdge(from.toString(), to.toString(), label);
  });

  dagre.layout(graph);

  const makeNode = (id: string) => {
    return { id: parseInt(id), label: graph.node(id) };
  };

  const makeEdge = (edge: Edge) => {
    return {
      from: parseInt(edge.v),
      to: parseInt(edge.w),
      label: graph.edge(edge)
    };
  };

  app.ports.getLayout.send({
    nodes: graph.nodes().map(makeNode),
    edges: graph.edges().map(makeEdge)
  });
});
