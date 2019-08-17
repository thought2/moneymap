module Main exposing (Edge, Entity(..), Graph, Model, Msg(..), Node, Organ(..), Party(..), drawGraph, drawNode, init, main, sampleData, update, view)

import Browser
import Collage exposing (..)
import Collage.Layout as CollageLayout
import Collage.Render as CollageRender
import Color exposing (..)
import Graph
import Point2d exposing (Point2d)

type alias Graph =
    Graph.Graph Node Edge


type alias Model =
    Graph


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
    = Politician PoliticianData
    | Company
    | PAC
    | Individual


type alias PoliticianData =
    { party : Party
    , organ : Organ
    }


type alias Edge =
    { money : Int }


sampleData : Graph
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
                , position = Point2d.origin
                }
            , Graph.Node 5
                { name = "John Barrasso"
                , entity = Politician { party = Republican, organ = Senate }
                , position = Point2d.origin
                }
            , Graph.Node 6
                { name = "Collin Peterson"
                , entity = Politician { party = Democrat, organ = House }
                , position = Point2d.origin
                }
            , Graph.Node 7
                { name = "Henry Cuellar"
                , entity = Politician { party = Democrat, organ = House }
                , position = Point2d.fromCoordinates ( 300.0, 100.0 )
                }
            , Graph.Node 8
                { name = "Cindy Hyde-Smith"
                , entity = Politician { party = Republican, organ = Senate }
                , position = Point2d.origin
                }
            , Graph.Node 9
                { name = "Luther Strange"
                , entity = Politician { party = Republican, organ = Senate }
                , position = Point2d.origin
                }
            , Graph.Node 10
                { name = "Deb Fischer"
                , entity = Politician { party = Republican, organ = Senate }
                , position = Point2d.origin
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
    ( sampleData, Cmd.none )


view : Model -> Browser.Document Msg
view model =
    { title = "MoneyMap"
    , body =
        [ CollageRender.svgBox ( 1500, 1500 ) (drawGraph model)
        ]
    }


drawGraph : Graph -> Collage msg
drawGraph graph =
    List.map drawNode (Graph.nodes graph)
        |> CollageLayout.stack


drawNode : Graph.Node Node -> Collage msg
drawNode { label } =
    let
        { position, entity, name } =
            label
    in
    shift (Point2d.coordinates label.position) <|
        case entity of
            Politician data ->
                drawPolitician data

            _ ->
                rectangle 10.0 10.0
                    |> filled (uniform grey)


drawPolitician : PoliticianData -> Collage msg
drawPolitician { party } =
    let
        color =
            case party of
                Democrat ->
                    blue

                Republican ->
                    red
    in
    circle 10.0
        |> filled (uniform color)



{-
   drawEntity : Node -> Entity -> Collage msg
   drawEntity {name}
-}
{-
   nodeCircle : (Graph.Node Node) -> Svg Msg
   nodeCircle {label} =
     circle [ cx <| (String.fromFloat (Point2d.xCoordinate label.position))
            , cy <| (String.fromFloat (Point2d.yCoordinate label.position))
            , r "5" ]
            []
-}


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )
