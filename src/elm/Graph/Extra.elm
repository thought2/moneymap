module Graph.Extra exposing (getEdge, getNode, zipWith)

import Graph exposing (Edge, Graph, Node, NodeId)
import IntDict
import Maybe.Extra as Maybe



-- TODO: Add documentation of the purpose of this module
-- TODO: Add documentation for the functions


getEdge : { from : NodeId, to : NodeId } -> Graph n e -> Maybe e
getEdge { from, to } graph =
    Graph.get from graph
        |> Maybe.andThen (\{ outgoing } -> IntDict.get to outgoing)


getNode : NodeId -> Graph n e -> Maybe n
getNode id graph =
    Graph.get id graph
        |> Maybe.map (.node >> .label)


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
