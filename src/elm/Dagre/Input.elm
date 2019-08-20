module Dagre.Output exposing (EdgeLabel, GraphLabel, NodeLabel, RankDir(..))

import Dagre.LowLevel.Graph as LowLevelGraph
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
    LowLevelGraph.Graph GraphLabel NodeLabel EdgeLabel


toLowLevel : Graph -> LowLevelInput.Graph
toLowLevel graph =
    graph
        |> LowLevelGraph.mapGraphLabel graphLabelToLowLevel
        |> LowLevelGraph.mapNodeLabel nodeLabelToLowLevel
        |> LowLevelGraph.mapEdgeLabel edgeLabelToLowLevel


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
