port module Dagre.LowLevel.Input exposing (EdgeLabel, Graph, GraphLabel, NodeLabel, setLayout)

import Graph exposing (NodeId)


type alias GraphLabel =
    { rankdir : String
    }


type alias NodeLabel =
    { width : Float
    , height : Float
    }


type alias EdgeLabel =
    { weight : Float
    }


type alias Graph =
    { label : GraphLabel
    , nodes : List { id : NodeId, label : NodeLabel }
    , edges : List { from : NodeId, to : NodeId, label : EdgeLabel }
    }


port setLayout : Graph -> Cmd msg
