module SampleData exposing (sampleData)

import CommonTypes exposing (..)
import Graph
import MoneyGraph exposing (MoneyGraph)
import Point2d


sampleData : MoneyGraph
sampleData =
    let
        nodes =
            [ Graph.Node 0
                { name = "NRA"
                , entity = Company
                , position = Point2d.fromCoordinates ( 150.0, 200.0 )
                }
            , Graph.Node 1
                { name = "Marsha Blackburn"
                , entity = Politician { party = Republican, organ = House }
                , position = Point2d.fromCoordinates ( 450.0, 143.0 )
                }
            , Graph.Node 2
                { name = "Ted Cruz"
                , entity = Politician { party = Republican, organ = Senate }
                , position = Point2d.fromCoordinates ( 30.0, 812.0 )
                }
            , Graph.Node 3
                { name = "Dean Heller"
                , entity = Politician { party = Republican, organ = Senate }
                , position = Point2d.fromCoordinates ( 601.0, 82.0 )
                }
            , Graph.Node 4
                { name = "Roger Wicker"
                , entity = Politician { party = Republican, organ = Senate }
                , position = Point2d.fromCoordinates ( 621.0, 23.0 )
                }
            , Graph.Node 5
                { name = "John Barrasso"
                , entity = Politician { party = Republican, organ = Senate }
                , position = Point2d.fromCoordinates ( 39.0, 800.0 )
                }
            , Graph.Node 5
                { name = "John Barrasso"
                , entity = Politician { party = Republican, organ = Senate }
                , position = Point2d.fromCoordinates ( 391.0, 589.0 )
                }
            , Graph.Node 6
                { name = "Collin Peterson"
                , entity = Politician { party = Democrat, organ = House }
                , position = Point2d.fromCoordinates ( 78.0, 256.0 )
                }
            , Graph.Node 7
                { name = "Henry Cuellar"
                , entity = Politician { party = Democrat, organ = House }
                , position = Point2d.fromCoordinates ( 300.0, 100.0 )
                }
            , Graph.Node 8
                { name = "Cindy Hyde-Smith"
                , entity = Politician { party = Republican, organ = Senate }
                , position = Point2d.fromCoordinates ( 129.0, 950.0 )
                }
            , Graph.Node 9
                { name = "Luther Strange"
                , entity = Politician { party = Republican, organ = Senate }
                , position = Point2d.fromCoordinates ( 9.0, 1000.0 )
                }
            , Graph.Node 10
                { name = "Deb Fischer"
                , entity = Politician { party = Republican, organ = Senate }
                , position = Point2d.fromCoordinates ( 470.0, 10.0 )
                }
            ]

        edges =
            [ Graph.Edge 0 1 { money = 15800 }
            , Graph.Edge 0 2 { money = 9900 }
            , Graph.Edge 0 3 { money = 9900 }
            , Graph.Edge 0 4 { money = 8950 }
            , Graph.Edge 0 5 { money = 5500 }
            , Graph.Edge 0 6 { money = 9900 }
            , Graph.Edge 0 7 { money = 6950 }
            , Graph.Edge 0 8 { money = 4950 }
            , Graph.Edge 0 9 { money = 4950 }
            , Graph.Edge 0 10 { money = 1000 }
            ]
    in
    Graph.fromNodesAndEdges nodes edges
