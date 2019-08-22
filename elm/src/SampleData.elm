module SampleData exposing (sampleData)

{-| Provides hardcoded sample data

@docs sampleData

-}

import CommonTypes exposing (..)
import Graph
import MoneyGraph.Data exposing (MoneyGraphData)



-- TODO: Get rid of sample data and use real data

{-| Some sample data that will be fetched from [opensecrets.org](www.opensecrets.org)
-}
sampleData : MoneyGraphData
sampleData =
    let
        nodes =
            [ Graph.Node 0
                { entity =
                    EntityCompany
                        { name = "NRA"
                        }
                }
            , Graph.Node 1
                { entity =
                    EntityPolitician
                        { name = "Marsha Blackburn"
                        , party = Republican
                        , organ = House
                        }
                }
            , Graph.Node 2
                { entity =
                    EntityPolitician
                        { name = "Ted Cruz"
                        , party = Republican
                        , organ = Senate
                        }
                }
            , Graph.Node 3
                { entity =
                    EntityPolitician
                        { name = "Dean Heller"
                        , party = Republican
                        , organ = Senate
                        }
                }
            , Graph.Node 4
                { entity =
                    EntityPolitician
                        { name = "Roger Wicker"
                        , party = Republican
                        , organ = Senate
                        }
                }
            , Graph.Node 5
                { entity =
                    EntityPolitician
                        { name = "John Barrasso"
                        , party = Republican
                        , organ = Senate
                        }
                }
            , Graph.Node 5
                { entity =
                    EntityPolitician
                        { name = "John Barrasso"
                        , party = Republican
                        , organ = Senate
                        }
                }
            , Graph.Node 6
                { entity =
                    EntityPolitician
                        { name = "Collin Peterson"
                        , party = Democrat
                        , organ = House
                        }
                }
            , Graph.Node 7
                { entity =
                    EntityPolitician
                        { name = "Henry Cuellar"
                        , party = Democrat
                        , organ = House
                        }
                }
            , Graph.Node 8
                { entity =
                    EntityPolitician
                        { name = "Cindy Hyde-Smith"
                        , party = Republican
                        , organ = Senate
                        }
                }
            , Graph.Node 9
                { entity =
                    EntityPolitician
                        { name = "Luther Strange"
                        , party = Republican
                        , organ = Senate
                        }
                }
            , Graph.Node 10
                { entity =
                    EntityPolitician
                        { name = "Deb Fischer"
                        , party = Republican
                        , organ = Senate
                        }
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
