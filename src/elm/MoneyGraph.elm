module MoneyGraph exposing (EdgeData, EdgeLabel, EdgeLayout, LayoutedMoneyGraph, MoneyGraph, NodeData, NodeLabel, NodeLayout, defaultEdgeLayout, defaultNodeLayout, toDagreInput, updateLayout)

-- Graph

import CommonTypes exposing (Entity)
import Dagre exposing (pointToVector2d, sizeToVector2d)
import Dict exposing (Dict)
import Graph exposing (Edge, Graph, Node, NodeId)
import Graph.Extra as Graph
import Maybe.Extra as Maybe
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


maybeNode :
    NodeId
    -> Dict Dagre.NodeId Dagre.Point
    -> LayoutedMoneyGraph
    -> Maybe (Node NodeLabel)
maybeNode id nodeDict graph =
    let
        maybeData : Maybe NodeData
        maybeData =
            Graph.getNode id graph |> Maybe.map .data

        maybeLayout : Maybe NodeLayout
        maybeLayout =
            Dict.get (String.fromInt id) nodeDict
                |> Maybe.map (\size -> { position = Dagre.pointToVector2d size })
    in
    Maybe.map2
        (\data layout ->
            Node id { data = data, layout = layout }
        )
        maybeData
        maybeLayout


maybeEdge :
    { from : NodeId, to : NodeId }
    -> Dict ( Dagre.NodeId, Dagre.NodeId ) (List Dagre.Point)
    -> LayoutedMoneyGraph
    -> Maybe (Edge EdgeLabel)
maybeEdge { from, to } edgeDict graph =
    let
        maybeData : Maybe EdgeData
        maybeData =
            Graph.getEdge { from = from, to = to } graph
                |> Maybe.map .data

        maybeLayout : Maybe EdgeLayout
        maybeLayout =
            Dict.get
                ( String.fromInt from, String.fromInt to )
                edgeDict
                |> Maybe.map
                    (\points ->
                        { points = List.map pointToVector2d points }
                    )
    in
    Maybe.map2
        (\data layout ->
            Edge from to { data = data, layout = layout }
        )
        maybeData
        maybeLayout


updateLayout : Dagre.Output -> LayoutedMoneyGraph -> Maybe LayoutedMoneyGraph
updateLayout { nodes, edges } graph =
    let
        maybeNodes : Maybe (List (Node NodeLabel))
        maybeNodes =
            Graph.nodeIds graph
                |> Maybe.traverse
                    (\id ->
                        maybeNode id (Dict.fromList nodes) graph
                    )

        maybeEdges : Maybe (List (Edge EdgeLabel))
        maybeEdges =
            Graph.edges graph
                |> Maybe.traverse
                    (\{ from, to } ->
                        maybeEdge { from = from, to = to } (Dict.fromList edges) graph
                    )
    in
    Maybe.map2 Graph.fromNodesAndEdges
        maybeNodes
        maybeEdges
