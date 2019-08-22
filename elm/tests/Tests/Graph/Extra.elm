module Tests.Graph.Extra exposing (suite)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import Graph exposing (Edge, Node)
import Graph.Extra as Graph
import Test exposing (..)


getEdge : Test
getEdge =
    describe "getEdge"
        [ test "edge does not exist" <|
            \_ ->
                Graph.getEdge { from = 0, to = 0 } Graph.empty
                    |> Expect.equal Nothing
        , test "edge does exist" <|
            \_ ->
                Graph.getEdge
                    { from = 0, to = 1 }
                    (Graph.fromNodesAndEdges
                        [ Node 0 (), Node 1 () ]
                        [ Edge 0 1 () ]
                    )
                    |> Expect.equal (Just ())
        ]


getNode : Test
getNode =
    describe "getNode"
        [ test "node does not exist" <|
            \_ ->
                Graph.getNode 0 Graph.empty
                    |> Expect.equal Nothing
        , test "node does exist" <|
            \_ ->
                Graph.getNode
                    0
                    (Graph.fromNodesAndEdges
                        [ Node 0 () ]
                        []
                    )
                    |> Expect.equal (Just ())
        ]


zipWith : Test
zipWith =
    describe "zipWith"
        [ test "structures don't match" <|
            \_ ->
                Graph.zipWith
                    (\_ _ -> ())
                    (\_ _ -> ())
                    Graph.empty
                    (Graph.fromNodesAndEdges
                        [ Node 0 () ]
                        []
                    )
                    |> Expect.equal Nothing
        , describe "structure matches"
            [ test "both graphs empty" <|
                \_ ->
                    Graph.zipWith
                        (\_ _ -> ())
                        (\_ _ -> ())
                        Graph.empty
                        Graph.empty
                        |> Expect.equal (Just Graph.empty)
            , test "both graphs non empty" <|
                \_ ->
                    Graph.zipWith
                        Tuple.pair
                        Tuple.pair
                        (Graph.fromNodesAndEdges
                            [ Node 0 "A1", Node 1 "B1" ]
                            [ Edge 0 1 "e1" ]
                        )
                        (Graph.fromNodesAndEdges
                            [ Node 0 "A2", Node 1 "B2" ]
                            [ Edge 0 1 "e2" ]
                        )
                        |> Expect.equal
                            (Just <|
                                Graph.fromNodesAndEdges
                                    [ Node 0 ( "A1", "A2" ), Node 1 ( "B1", "B2" ) ]
                                    [ Edge 0 1 ( "e1", "e2" ) ]
                            )
            ]
        ]


suite : Test
suite =
    describe "module Graph.Extra"
        [ getEdge
        , getNode
        , zipWith
        ]
