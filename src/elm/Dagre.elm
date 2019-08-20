module Dagre exposing (Input, InputGraphLabel, RankDir(..))

import Dagre.LowLevel.Input as LowLevelInput
import Dagre.LowLevel.Output as LowLevelInput

import Dagre.LowLevel.Graph exposing ( Graph)


defaultInputGraphLabel : InputGraphLabel
defaultInputGraphLabel =
    { rankDir = TopBottom
    }


inputToLowLevel : Input -> LowLevel.Input
inputToLowLevel value =
    { label = inputGraphLabelToLowLevel value.graph
    , nodes = List.map inputNodeLabelToLowLevel value.nodes
    , edges = List.map inputEdgeLabelToLowLevel value.edges
    }




apLabel :