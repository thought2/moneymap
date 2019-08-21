module Dagre.Input exposing (EdgeLabel, Graph, GraphLabel, NodeLabel, RankDir(..), defaultEdgeLabel, defaultGraphLabel, defaultNodeLabel, toLowLevel)

import Dagre.Graph as Graph
import Dagre.LowLevel.Input as LowLevelInput


type RankDir
    = TopBottom
    | BottomTop
    | LeftRight
    | RightLeft


type alias GraphLabel =
    { rankDir : RankDir }


type alias NodeLabel =
    { size : ( Float, Float )
    }


type alias EdgeLabel =
    { weight : Float
    }


type alias Graph =
    Graph.Graph GraphLabel NodeLabel EdgeLabel


toLowLevel : Graph -> LowLevelInput.Graph
toLowLevel graph =
    graph
        |> Graph.mapGraphLabel graphLabelToLowLevel
        |> Graph.mapNodeLabel nodeLabelToLowLevel
        |> Graph.mapEdgeLabel edgeLabelToLowLevel


graphLabelToLowLevel : GraphLabel -> LowLevelInput.GraphLabel
graphLabelToLowLevel value =
    { rankdir = rankDirToString value.rankDir
    }


nodeLabelToLowLevel : NodeLabel -> LowLevelInput.NodeLabel
nodeLabelToLowLevel value =
    { width = Tuple.first value.size
    , height = Tuple.second value.size
    }


edgeLabelToLowLevel : EdgeLabel -> LowLevelInput.EdgeLabel
edgeLabelToLowLevel value =
    { weight = value.weight
    }


rankDirToString : RankDir -> String
rankDirToString rankDir =
    case rankDir of
        TopBottom ->
            "TB"

        BottomTop ->
            "BT"

        LeftRight ->
            "LR"

        RightLeft ->
            "RL"



-- DEFAULT


defaultGraphLabel : GraphLabel
defaultGraphLabel =
    { rankDir = TopBottom }


defaultNodeLabel : NodeLabel
defaultNodeLabel =
    { size = ( 0.0, 0.0 )
    }


defaultEdgeLabel : EdgeLabel
defaultEdgeLabel =
    { weight = 1.0
    }
