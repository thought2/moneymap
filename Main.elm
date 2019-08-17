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


main =
  text "Hello, world!"

