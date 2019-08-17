import Html exposing (text, div, pre)
import Browser
import Graph
import Point2d exposing (Point2d)
import Collage exposing (circle, rectangle, filled, uniform)
import Collage.Layout exposing (at, topLeft)
import Collage.Render exposing (svg)

type alias Graph = Graph.Graph Node Edge

type alias Model = Graph


type Party 
  = Democrat
  | Republican

type Organ 
  = House
  | Senate

type alias Node =
  { name : String
  , entity : Entity
  , position : Point2d
  }

type Entity 
  = Politician {party : Party, organ : Organ } 
  | Company
  | PAC
  | Individual

type alias Edge = { money : Int }



sampleData : Graph
sampleData = 
  let
    nodes =
      [ Graph.Node 0 
        { name = "NRA"
        , entity = Company
        , position = Point2d.origin
        }
      , Graph.Node 1 
        { name = "Marsha Blackburn"
        , entity = Politician {party = Republican, organ = House} 
        , position = Point2d.origin
        }
        , Graph.Node 2 
        { name = "Ted Cruz"
        , entity = Politician {party = Republican, organ = Senate} 
        , position = Point2d.origin
        }
         , Graph.Node 3 
        { name = "Dean Heller"
        , entity = Politician {party = Republican, organ = Senate} 
        , position = Point2d.origin
        }
          , Graph.Node 4 
        { name = "Roger Wicker"
        , entity = Politician {party = Republican, organ = Senate} 
        , position = Point2d.origin
        }
          , Graph.Node 5 
        { name = "John Barrasso"
        , entity = Politician {party = Republican, organ = Senate} 
        , position = Point2d.origin
        }
         , Graph.Node 5 
        { name = "John Barrasso"
        , entity = Politician {party = Republican, organ = Senate} 
        , position = Point2d.origin
        }
          , Graph.Node 6 
        { name = "Collin Peterson"
        , entity = Politician {party = Democrat, organ = House} 
        , position = Point2d.origin
        }
         , Graph.Node 7 
        { name = "Henry Cuellar"
        , entity = Politician {party = Democrat, organ = House} 
        , position = Point2d.origin
        }
         , Graph.Node 8 
        { name = "Cindy Hyde-Smith"
        , entity = Politician {party = Republican, organ = Senate} 
        , position = Point2d.origin
        }
         , Graph.Node 9 
        { name = "Luther Strange"
        , entity = Politician {party = Republican, organ = Senate} 
        , position = Point2d.origin
        }
         , Graph.Node 10 
        { name = "Deb Fischer"
        , entity = Politician {party = Republican, organ = Senate} 
        , position = Point2d.origin
        }
      ]

    edges =
      [ Graph.Edge 0 1 { money = 15800},
      Graph.Edge 0 2 { money = 9900},
      Graph.Edge 0 3 { money = 9900},
      Graph.Edge 0 4 { money = 8950},
      Graph.Edge 0 5 { money = 5500},
      Graph.Edge 0 6 { money = 9900},
      Graph.Edge 0 7 { money = 6950},
      Graph.Edge 0 8 { money = 4950},
      Graph.Edge 0 9 { money = 4950},
      Graph.Edge 0 10 { money = 1000}
      ]
  in
    Graph.fromNodesAndEdges nodes edges

main : Program () Model Msg
main =
  Browser.document 
    { init = init
    , view = view
    , update = update
    , subscriptions = \_ -> Sub.none
    }


type Msg 
  = Pan

init _ = 
  (sampleData, Cmd.none)


view : Model -> Browser.Document Msg
view model = 
  { title = "MoneyMap"
  , body =  
    [ 
      pre [] [text (Debug.toString model)] 
    ]
  }


update : Msg -> Model -> (Model, Cmd Msg)
update msg model = 
  (model, Cmd.none)
