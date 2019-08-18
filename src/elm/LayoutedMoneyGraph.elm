module LayoutedMoneyGraph exposing (Edge, LayoutedMoneyGraph, Node, NodeLabel, toLayoutedGraph, updateLayout)

-- Graph

import Graph exposing (Graph)
import Graph.Extra as Graph
import LayoutedGraph exposing (LayoutedGraph)
import MoneyGraph


type alias LayoutedMoneyGraph =
    Graph NodeLabel EdgeLabel



-- Node


type alias NodeLabel =
    { data : MoneyGraph.NodeLabel
    , layout : LayoutedGraph.NodeLabel
    }


type alias Node =
    Graph.Node NodeLabel



-- Edge


type alias EdgeLabel =
    { data : MoneyGraph.EdgeLabel
    , layout : LayoutedGraph.EdgeLabel
    }


type alias Edge =
    Graph.Edge EdgeLabel



-- Util


updateLayout : LayoutedGraph -> LayoutedMoneyGraph -> Maybe LayoutedMoneyGraph
updateLayout layoutedGraph graph =
    Graph.zipWith
        (\layout node2 -> { node2 | layout = layout })
        (\layout edge2 -> { edge2 | layout = layout })
        layoutedGraph
        graph


toLayoutedGraph : LayoutedMoneyGraph -> LayoutedGraph
toLayoutedGraph graph =
    graph
        |> Graph.mapNodes .layout
        |> Graph.mapEdges .layout
