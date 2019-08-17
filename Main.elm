import Html exposing (text, div, pre)
import Browser
import Graph
import Point2d exposing (Point2d)

type alias Graph = Graph.Graph Node Edge

type alias Model = Graph


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
  , body =  [ pre [] [text (Debug.toString model)] ]
  }


update : Msg -> Model -> (Model, Cmd Msg)
update msg model = 
  (model, Cmd.none)
