module MoneyGraph exposing (EdgeData, EdgeLabel, EdgeLayout, LayoutedMoneyGraph, MoneyGraph, NodeData, NodeLabel, NodeLayout, defaultEdgeLayout, defaultNodeLayout, toDagreInput, updateLayout)

-- Graph

import CommonTypes exposing (Entity)
import Dagre
import Graph exposing (Graph)
import Vector2d exposing (Vector2d)



-- Graph


type alias MoneyGraph =
    Graph NodeData EdgeData


type alias LayoutedMoneyGraph =
    Graph NodeLabel EdgeLabel



-- Node


type alias NodeData =
    { name : String
    , entity : Entity
    }


type alias NodeLayout =
    { position : Vector2d
    }


defaultNodeLayout : NodeLayout
defaultNodeLayout =
    { position = Vector2d.zero }


type alias NodeLabel =
    { data : NodeData
    , layout : NodeLayout
    }



-- Edge


type alias EdgeData =
    { money : Int
    }


type alias EdgeLayout =
    { points : List Vector2d
    }


defaultEdgeLayout : EdgeLayout
defaultEdgeLayout =
    { points = [] }


type alias EdgeLabel =
    { data : EdgeData
    , layout : EdgeLayout
    }



-- Utils


toDagreInput : LayoutedMoneyGraph -> Dagre.Input
toDagreInput graph =
    let
        makeNode : Graph.Node NodeLabel -> Dagre.InputNode
        makeNode { id, label } =
            { id = String.fromInt id
            , layout = { width = 0.1, height = 0.1 }
            }

        makeEdge : Graph.Edge EdgeLabel -> Dagre.InputEdge
        makeEdge { from, to, label } =
            { from = String.fromInt from
            , to = String.fromInt to
            }
    in
    { nodes = List.map makeNode (Graph.nodes graph)
    , edges = List.map makeEdge (Graph.edges graph)
    }


updateLayout : Dagre.Output -> LayoutedMoneyGraph -> LayoutedMoneyGraph
updateLayout =
    Debug.todo "updateLayout"
