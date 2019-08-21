module Graph.WithLabel exposing (GraphWithLabel, fromDagre, mapEdges, mapGraph, mapLabel, mapNodes, toDagre, zipWith)

import Dagre.Graph
import Graph exposing (Edge, Graph, Node)
import Graph.Extra as Graph


type alias GraphWithLabel g n e =
    { label : g
    , graph : Graph n e
    }


mapLabel : (g1 -> g2) -> GraphWithLabel g1 n e -> GraphWithLabel g2 n e
mapLabel f labeledGraph =
    { label = f labeledGraph.label
    , graph = labeledGraph.graph
    }


mapNodes : (n1 -> n2) -> GraphWithLabel g n1 e -> GraphWithLabel g n2 e
mapNodes f labeledGraph =
    mapGraph (Graph.mapNodes f) labeledGraph


mapEdges : (e1 -> e2) -> GraphWithLabel g n e1 -> GraphWithLabel g n e2
mapEdges f labeledGraph =
    mapGraph (Graph.mapEdges f) labeledGraph


mapGraph :
    (Graph n1 e1 -> Graph n2 e2)
    -> GraphWithLabel g n1 e1
    -> GraphWithLabel g n2 e2
mapGraph f graphWithLabel =
    { label = graphWithLabel.label
    , graph = f graphWithLabel.graph
    }


zipWith :
    (g1 -> g2 -> g3)
    -> (n1 -> n2 -> n3)
    -> (e1 -> e2 -> e3)
    -> GraphWithLabel g1 n1 e1
    -> GraphWithLabel g2 n2 e2
    -> Maybe (GraphWithLabel g3 n3 e3)
zipWith mapGraph_ mapNode mapEdge graphWithLabel1 graphWithLabel2 =
    let
        maybeGraph =
            Graph.zipWith
                mapNode
                mapEdge
                graphWithLabel1.graph
                graphWithLabel2.graph
    in
    Maybe.map
        (\graph ->
            { label = mapGraph_ graphWithLabel1.label graphWithLabel2.label
            , graph = graph
            }
        )
        maybeGraph


fromDagre : Dagre.Graph.Graph g n e -> GraphWithLabel g n e
fromDagre dagreGraph =
    let
        graph =
            Graph.fromNodesAndEdges
                dagreGraph.nodes
                dagreGraph.edges
    in
    { label = dagreGraph.label
    , graph = graph
    }


toDagre : GraphWithLabel g n e -> Dagre.Graph.Graph g n e
toDagre { label, graph } =
    { label = label
    , nodes = Graph.nodes graph
    , edges = Graph.edges graph
    }
