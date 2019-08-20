module Dagre.Output exposing (EdgeLabel, GraphLabel, NodeLabel)

import Dagre.LowLevel.Graph as LowLevelGraph
import Dagre.LowLevel.Output as LowLevelOutput


type alias GraphLabel =
    { size : ( Float, Float )
    }


type alias NodeLabel =
    { position : ( Float, Float )
    }


type alias EdgeLabel =
    { position : ( Float, Float )
    , points : List ( Float, Float )
    }


type alias Graph =
    LowLevelGraph.Graph GraphLabel NodeLabel EdgeLabel


toLowLevel : Graph -> LowLevelOutput.Graph
toLowLevel graph =
    graph
        |> LowLevelGraph.mapGraphLabel graphLabelToLowLevel
        |> LowLevelGraph.mapNodeLabel nodeLabelToLowLevel
        |> LowLevelGraph.mapEdgeLabel edgeLabelToLowLevel


graphLabelToLowLevel : GraphLabel -> LowLevelOutput.GraphLabel
graphLabelToLowLevel value =
    { width = Tuple.first value.size
    , height = Tuple.second value.size
    }


nodeLabelToLowLevel : NodeLabel -> LowLevelOutput.NodeLabel
nodeLabelToLowLevel value =
    { x = Tuple.first value.position
    , y = Tuple.second value.position
    }


edgeLabelToLowLevel : EdgeLabel -> LowLevelOutput.EdgeLabel
edgeLabelToLowLevel value =
    let
        makePoint point =
            { x = Tuple.first point
            , y = Tuple.second point
            }
    in
    { x = Tuple.first value.position
    , y = Tuple.second value.position
    , points = List.map makePoint value.points
    }
