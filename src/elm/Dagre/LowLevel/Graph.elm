module Dagre.LowLevel.Graph exposing (Edge, Graph, Node, NodeId, mapEdgeLabel, mapGraphLabel, mapNodeLabel)


type alias NodeId =
    Int


type alias Node n =
    { id : NodeId, label : n }


type alias Edge e =
    { from : NodeId, to : NodeId, label : e }


type alias Graph g n e =
    { label : g
    , nodes : List (Node n)
    , edges : List (Edge e)
    }


mapGraphLabel : (g1 -> g2) -> Graph g1 n e -> Graph g2 n e
mapGraphLabel f graph =
    { label = f graph.label
    , nodes = graph.nodes
    , edges = graph.edges
    }


mapNodeLabel : (n1 -> n2) -> Graph g n1 e -> Graph g n2 e
mapNodeLabel f graph =
    let
        mapNode node =
            { id = node.id
            , label = f node.label
            }
    in
    { label = graph.label
    , nodes = List.map mapNode graph.nodes
    , edges = graph.edges
    }


mapEdgeLabel : (e1 -> e2) -> Graph g n e1 -> Graph g n e2
mapEdgeLabel f graph =
    let
        mapEdge edge =
            { from = edge.from
            , to = edge.to
            , label = f edge.label
            }
    in
    { label = graph.label
    , nodes = graph.nodes
    , edges = List.map mapEdge graph.edges
    }
