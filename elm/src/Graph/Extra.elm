module Graph.Extra exposing (getEdge, getNode, zipWith)

{-| This module extends the [elm-community/graph](https://package.elm-lang.org/packages/elm-community/graph/latest/) package

It is meant to be imported like

    import Graph
    import Graph.Extra as Graph

    -- and used like

    Graph.getNode 0 Graph.empty --> Nothing

@docs getEdge, getNode, zipWith

-}

import Graph exposing (Edge, Graph, Node, NodeId)
import IntDict
import Maybe.Extra as Maybe


{-| Get the _edge label_ from given source and target `NodeId`'s if exsiting
-}
getEdge : { from : NodeId, to : NodeId } -> Graph n e -> Maybe e
getEdge { from, to } graph =
    Graph.get from graph
        |> Maybe.andThen (\{ outgoing } -> IntDict.get to outgoing)


{-| Get the _node label_ from a given `NodeId` if existing
-}
getNode : NodeId -> Graph n e -> Maybe n
getNode id graph =
    Graph.get id graph
        |> Maybe.map (.node >> .label)


{-| Combines two graphs into a new one if their node and edge structure matches exactly.
Uses a function to map the _nodes_ and one to map the _edges_.

    import Graph exposing (Graph, Node, Edge)

    graph1 : Graph String String
    graph1 =
        Graph.fromNodesAndEdges
          [ Node 0 "A1", Node 1 "B1" ]
          [ Edge 0 1 "e1" ]


    graph2 : Graph String String
    graph2 = Graph.fromNodesAndEdges
          [ Node 0 "A2", Node 1 "B2" ]
          [ Edge 0 1 "e2" ]


    graph : Graph (String, String) (String, String)
    graph = Graph.fromNodesAndEdges
          [ Node 0 ("A1", "A2"), Node 1 ("B1", "B2") ]
          [ Edge 0 1 ("e1", "e2") ]


    zipWith Tuple.pair Tuple.pair graph1 graph2
    --> Just graph

    zipWith Tuple.pair Tuple.pair graph1 Graph.empty
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
    if structureMatches graph1 graph2 then
        Maybe.map2 Graph.fromNodesAndEdges
            maybeNodes
            maybeEdges

    else
        Nothing


structureMatches : Graph n1 e1 -> Graph n2 e2 -> Bool
structureMatches graph1 graph2 =
    let
        nodesIdsMatch =
            List.sort (Graph.nodeIds graph1)
                == List.sort (Graph.nodeIds graph2)

        edgeIdsMatch =
            (Graph.edges graph1 |> List.map getEdgeId |> List.sort)
                == (Graph.edges graph1 |> List.map getEdgeId |> List.sort)

        getEdgeId { from, to } =
            ( from, to )
    in
    nodesIdsMatch && edgeIdsMatch
