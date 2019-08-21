module Dagre.Output exposing (EdgeLabel, Graph, GraphLabel, NodeLabel, fromLowLevel)

import Dagre.Graph as Graph
import Dagre.LowLevel.Output as LowLevelOutput


type alias GraphLabel =
    { size : ( Float, Float )
    }


type alias NodeLabel =
    { position : ( Float, Float )
    }


type alias EdgeLabel =
    { points : List ( Float, Float )
    }


type alias Graph =
    Graph.Graph GraphLabel NodeLabel EdgeLabel


fromLowLevel : LowLevelOutput.Graph -> Graph
fromLowLevel graph =
    graph
        |> Graph.mapGraphLabel graphLabelFromLowLevel
        |> Graph.mapNodeLabel nodeLabelFromLowLevel
        |> Graph.mapEdgeLabel edgeLabelFromLowLevel


graphLabelFromLowLevel : LowLevelOutput.GraphLabel -> GraphLabel
graphLabelFromLowLevel value =
    { size = ( value.width, value.height )
    }


nodeLabelFromLowLevel : LowLevelOutput.NodeLabel -> NodeLabel
nodeLabelFromLowLevel value =
    { position = ( value.x, value.y )
    }


edgeLabelFromLowLevel : LowLevelOutput.EdgeLabel -> EdgeLabel
edgeLabelFromLowLevel value =
    let
        makePoint { x, y } =
            ( x, y )
    in
    { points = List.map makePoint value.points
    }
