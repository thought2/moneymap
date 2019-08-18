module Graph.Extra exposing (getEdge, getNode, zipWith)

import Graph exposing (Edge, Graph, Node, NodeId)
import IntDict
import Maybe.Extra as Maybe


getEdge : { from : NodeId, to : NodeId } -> Graph n e -> Maybe e
getEdge { from, to } graph =
    Graph.get from graph
        |> Maybe.andThen (\{ outgoing } -> IntDict.get to outgoing)


getNode : NodeId -> Graph n e -> Maybe n
getNode id graph =
    Graph.get id graph
        |> Maybe.map (.node >> .label)


mapNodes2 : (n1 -> n2 -> n3) -> Graph n1 e -> Graph n2 e -> Maybe (Graph n3 e)
mapNodes2 f graph1 graph2 =
    let
        maybeNodes : Maybe (List (Node n3))
        maybeNodes =
            Graph.nodeIds graph1
                |> Maybe.traverse
                    (\id ->
                        Maybe.map2
                            (\node1 node2 ->
                                Node id (f node1 node2)
                            )
                            (getNode id graph1)
                            (getNode id graph2)
                    )

        edges : List (Edge e)
        edges =
            Graph.edges graph1
    in
    maybeNodes
        |> Maybe.map
            (\nodes ->
                Graph.fromNodesAndEdges nodes edges
            )


zipWith :
    (n1 -> n2 -> n3)
    -> (e1 -> e2 -> e3)
    -> Graph n1 e1
    -> Graph n2 e2
    -> Maybe (Graph n3 e3)
zipWith nodeMapper edgeMapper graph1 graph2 =
    let
        maybeNodes : Maybe (List (Node n3))
        maybeNodes =
            Graph.nodeIds graph1
                |> Maybe.traverse
                    (\id ->
                        Maybe.map2
                            (\node1 node2 ->
                                Node id (nodeMapper node1 node2)
                            )
                            (getNode id graph1)
                            (getNode id graph2)
                    )

        maybeEdges : Maybe (List (Edge e3))
        maybeEdges =
            Graph.edges graph1
                |> Maybe.traverse
                    (\{ from, to } ->
                        Maybe.map2
                            (\edge1 edge2 ->
                                Edge from to (edgeMapper edge1 edge2)
                            )
                            (getEdge { from = from, to = to } graph1)
                            (getEdge { from = from, to = to } graph2)
                    )
    in
    Maybe.map2 Graph.fromNodesAndEdges
        maybeNodes
        maybeEdges
