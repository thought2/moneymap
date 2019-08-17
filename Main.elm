import Html exposing (text)
import Graph
import Point2d exposing (Point2d)

type alias Graph = Graph.Graph Node Edge

type Party 
  = Democrat
  | Republican

type alias Node =
  { name : String
  , entity : Entity
  , position : Point2d
  }

type Entity 
  = Politician
  | Company
  | PAC
  | Individual

type alias Edge = Int



sampleData : Graph
sampleData = 
  let
    nodes =
      [ Graph.Node 0 
        { name = "Marsha Blackburn"
        , entity = Politician
        , position = Point2d.origin
        }
      , Graph.Node 1 
        { name = "Marsha Blackburn"
        , entity = PAC
        , position = Point2d.origin
        }
      ]

    e from to =
      Graph.Edge from to 

    edges =
      [ e 0 1 1000
      ]
  in
    Graph.fromNodesAndEdges nodes edges

main =
  text "Hello, world!"

