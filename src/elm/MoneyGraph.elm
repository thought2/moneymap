module MoneyGraph exposing (Edge, EdgeLabel, GraphLabel, MoneyGraph, Node, NodeLabel, fromData, toDagre, updateWithDagre)

import Dagre.Input
import Dagre.Output
import Graph exposing (Graph)
import Graph.WithLabel as GraphWithLabel exposing (GraphWithLabel)
import MoneyGraph.Data exposing (MoneyGraphData)
import MoneyGraph.Visual
import Vector2d


type alias MoneyGraph =
    GraphWithLabel GraphLabel NodeLabel EdgeLabel



-- Graph


type alias GraphLabel =
    { data : ()
    , layout : MoneyGraph.Visual.GraphLabel
    }



-- Node


type alias NodeLabel =
    { data : MoneyGraph.Data.NodeLabel
    , layout : MoneyGraph.Visual.NodeLabel
    }



-- Edge


type alias EdgeLabel =
    { data : MoneyGraph.Data.EdgeLabel
    , layout : MoneyGraph.Visual.EdgeLabel
    }



-- Shorthands


type alias Edge =
    Graph.Edge EdgeLabel


type alias Node =
    Graph.Node NodeLabel



-- Util


toDagre : MoneyGraph -> Dagre.Input.Graph
toDagre graph =
    let
        makeLabel _ =
            Dagre.Input.defaultGraphLabel

        makeNode { layout } =
            Dagre.Input.defaultNodeLabel
                |> (\r ->
                        { r | size = Vector2d.components layout.size }
                   )

        makeEdge _ =
            Dagre.Input.defaultEdgeLabel
                |> (\r ->
                        { r | weight = 1.0 }
                   )
    in
    graph
        |> GraphWithLabel.mapLabel makeLabel
        |> GraphWithLabel.mapNodes makeNode
        |> GraphWithLabel.mapEdges makeEdge
        |> GraphWithLabel.toDagre


updateWithDagre : Dagre.Output.Graph -> MoneyGraph -> Maybe MoneyGraph
updateWithDagre dagreGraph labeledGraph =
    let
        makeLabel x y =
            { y
                | size =
                    Vector2d.fromComponents x.size
            }

        makeNode x y =
            { y
                | position =
                    Vector2d.fromComponents x.position
            }

        makeEdge x y =
            { y
                | points =
                    List.map Vector2d.fromComponents x.points
            }

        updateLayout f r1 r2 =
            { r2 | layout = f r1 r2.layout }
    in
    GraphWithLabel.zipWith
        (updateLayout makeLabel)
        (updateLayout makeNode)
        (updateLayout makeEdge)
        (GraphWithLabel.fromDagre dagreGraph)
        labeledGraph


fromData : MoneyGraphData -> MoneyGraph
fromData moneyData =
    let
        label =
            { data = ()
            , layout =
                MoneyGraph.Visual.defaultGraphLabel
            }

        addLayout layout data =
            { data = data, layout = layout }

        graph =
            moneyData
                |> Graph.mapNodes
                    (addLayout MoneyGraph.Visual.defaultNodeLabel)
                |> Graph.mapEdges
                    (addLayout MoneyGraph.Visual.defaultEdgeLabel)
    in
    { label = label
    , graph = graph
    }
