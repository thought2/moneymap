module Dagre exposing (..)

import Graph exposing (Edge, Graph, Node)
import Vector2d as Vector2d exposing (Vector2d)


type alias InputGraph =
    Graph InputNodeLabel InputEdgeLabel


type alias OutputGraph =
    Graph OutputNodeLabel OutputEdgeLabel



-- API


setLayout : InputGraph -> Cmd msg
setLayout graph =
    setLayoutImpl <| graphToInput graph


getLayout : (OutputGraph -> msg) -> Sub msg
getLayout f =
    getLayoutImpl (outputToGraph >> f)


-- UTILS



outputToGraph : Output -> OutputGraph
outputToGraph { nodes, edges } =
    let
        makeNode ( id, label ) =
            Node id label

        makeEdge ( { from, to }, label ) =
            Edge from to label
    in
    Graph.fromNodesAndEdges
        (List.map makeNode nodes)
        (List.map makeEdge edges)


graphToInput : InputGraph -> Input
graphToInput graph =
    let
        makeNode { id, label } =
            ( id, label )

        makeEdge { from, to, label } =
            ( { from = from, to = to }, label )
    in
    { nodes = List.map makeNode (Graph.nodes graph)
    , edges = List.map makeEdge (Graph.edges graph)
    }

