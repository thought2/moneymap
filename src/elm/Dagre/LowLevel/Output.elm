module Dagre.LowLevel.Output exposing (EdgeLabel, Graph, GraphLabel, NodeLabel)

import Graph exposing (NodeId)


type alias GraphLabel =
    { width : Float
    , height : Float
    }


type alias NodeLabel =
    { x : Float
    , y : Float
    }


type alias EdgeLabel =
    { x : Float
    , y : Float
    , points : List { x : Float, y : Float }
    }


type alias Graph =
    { label : GraphLabel
    , nodes : List { id : NodeId, label : NodeLabel }
    , edges : List { from : NodeId, to : NodeId, label : EdgeLabel }
    }
