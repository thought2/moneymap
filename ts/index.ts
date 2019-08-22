import { Elm } from "../elm/src/Main";
import dagre, { Edge } from "dagre";

const app = Elm.Main.init({
  node: document.getElementById("app"),
  flags: null
});

type Input = {
  label: dagre.GraphLabel;
  nodes: Array<{ id: number; label: dagre.NodeConfig }>;
  edges: Array<{ from: number; to: number; label: dagre.EdgeConfig }>;
};

type Output = {
  label: { width: number; height: number };
  nodes: Array<{ id: number; label: dagre.Node }>;
  edges: Array<{ from: number; to: number; label: GraphEdge }>;
};

type GraphEdge = {
  points: Array<{ x: number; y: number }>;
  x: number;
  y: number;
};

const portSetLayout = ({ label, nodes, edges }: Input) => {
  var graph = new dagre.graphlib.Graph();

  graph.setGraph(label);

  nodes.forEach(({ id, label }) => {
    graph.setNode(id.toString(), label);
  });

  edges.forEach(({ from, to, label }) => {
    graph.setEdge(from.toString(), to.toString(), label);
  });

  dagre.layout(graph);

  const makeNode = (id: string): { id: number; label: dagre.Node } => {
    return { id: parseInt(id), label: graph.node(id) };
  };

  const makeEdge = (
    edge: Edge
  ): { from: number; to: number; label: GraphEdge } => {
    return {
      from: parseInt(edge.v),
      to: parseInt(edge.w),
      label: graph.edge(edge) as GraphEdge
    };
  };

  app.ports.getLayout.send({
    label: { width: 0, height: 0 }, // TODO: Use real output from dagre
    nodes: graph.nodes().map(makeNode),
    edges: graph.edges().map(makeEdge)
  });
};

app.ports.setLayout.subscribe(portSetLayout);
