module LayoutedGraph exposing (EdgeLabel, LayoutedGraph, NodeLabel, defaultEdgeLabel, defaultNodeLabel)

-- Graph

import Graph exposing (Graph)
import Vector2d exposing (Vector2d)


type alias LayoutedGraph =
    Graph NodeLabel EdgeLabel


type alias NodeLabel =
    { position : Vector2d
    , size : Vector2d
    }


type alias EdgeLabel =
    { points : List Vector2d
    }



-- Defaults


defaultNodeLabel : NodeLabel
defaultNodeLabel =
    { position = Vector2d.zero
    , size = Vector2d.fromComponents ( 10.0, 10.0 )
    }


defaultEdgeLabel : EdgeLabel
defaultEdgeLabel =
    { points = [] }
