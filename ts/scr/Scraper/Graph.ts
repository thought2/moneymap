import * as Api from "./Api";
import { Individual, Organisation } from "./Types";
import * as _ from "lodash";
import { allInSeq } from "../Promise";

// Types

type Node =
  | { tag: "Organisation" } & Organisation
  | { tag: "Individual" } & Individual;

type Edge = { cycle: number; money: number };

type NodeId = string;

type Graph = {
  nodes: Map<NodeId, Node>;
  edges: Array<{ from: NodeId; to: NodeId; label: Edge }>;
};

type GraphData = {
  nodes: Array<Node>;
  edges: Array<{ from: NodeId; to: NodeId; label: Edge }>;
};

export const toGraphData = (graph: Graph): GraphData => {
  return { nodes: Array.from(graph.nodes.values()), edges: graph.edges };
};

// Scrape

export const getGraph = (size?: number): Promise<Graph> => {
  const graph = { nodes: new Map(), edges: [] };

  return Api.getCycles()
    .then(cycles => (size ? _.take(cycles, size) : cycles))
    .then(cycles =>
      allInSeq(cycles.map(cycle => setOrganisations(graph, cycle, size)))
    );
};

const setOrganisations = (
  graph: Graph,
  cycle: number,
  size?: number
): Promise<Graph> => {
  return Api.getOrganisations({ cycle })
    .then(orgs => (size ? _.take(orgs, size) : orgs))
    .then(orgs => {
      return allInSeq(
        orgs.map(organisation => {
          graph.nodes.set(organisation.id, {
            tag: "Organisation",
            ...organisation
          });

          return setRecipients(graph, cycle, organisation, size);
        })
      );
    });
};

const setRecipients = (
  graph: Graph,
  cycle: number,
  organisation: Organisation,
  size?: number
): Promise<Graph> => {
  return Api.getRecipients({ id: organisation.id, cycle })
    .then(recipients => (size ? _.take(recipients, size) : recipients))
    .then(recipients => {
      recipients.forEach(recipient => {
        const { individual, money } = recipient;

        graph.nodes.set(individual.id, { tag: "Individual", ...individual });
        graph.edges.push({
          from: organisation.id,
          to: individual.id,
          label: { cycle, money }
        });
      });
      return Promise.resolve(graph);
    });
};
