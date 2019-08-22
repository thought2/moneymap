module Graph.Extra exposing (getEdge, getNode, zipWith)

{-| This module extends the [elm-community/graph](https://package.elm-lang.org/packages/elm-community/graph/latest/) package

It is meant to be imported like

    import Graph as Graph
    import Graph.Extra as Graph

    -- and used like

    Graph.getNode 0 Graph.empty --> Nothing

@docs getEdge, getNode, zipWith

-}

import Graph exposing (Edge, Graph, Node, NodeId)
import IntDict
import Maybe.Extra as Maybe


{-| Get the edge label from given source and target `NodeId`'s if exsiting
-}
getEdge : { from : NodeId, to : NodeId } -> Graph n e -> Maybe e
getEdge { from, to } graph =
    Graph.get from graph
        |> Maybe.andThen (\{ outgoing } -> IntDict.get to outgoing)


{-| Get the node label from a given `NodeId` if existing
-}
getNode : NodeId -> Graph n e -> Maybe n
getNode id graph =
    Graph.get id graph
        |> Maybe.map (.node >> .label)


{-| Combines two graphs into a new one if their node and edge structure matches exactly

    import Graph exposing (Graph, Node, Edge)

    graph1 : Graph String ()
    graph1 =
        Graph.fromNodesAndEdges
          [ Node 0 "A", Node 1 "B" ]
          [ Edge 0 1 () ]

    graph2 : Graph String ()
    graph2 =
        Graph.fromNodesAndEdges
          [ Node 0 "a", Node 1 "b" ]
          []

    graph3 : Graph String ()
    graph3 = Graph.fromNodesAndEdges
          [ Node 0 "AA", Node 1 "BB" ] [ Edge 0 1 () ]

    zipWith (++) (\_ _ -> ()) graph1 graph1
    --> Just graph3

    zipWith (++) (\_ _ -> ()) graph1 graph2
    --> Nothing

-}
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
