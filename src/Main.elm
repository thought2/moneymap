module Main exposing (Model, Msg(..), draw, drawEdge, drawNode, drawPolitician, init, main, update, view)

import Browser
import Collage exposing (..)
import Collage.Events as CollageEvents
import Collage.Layout as CollageLayout
import Collage.Render as CollageRender
import Collage.Text as CollageText
import Color exposing (..)
import Graph
import Point2d exposing (Point2d)
import SampleData exposing (sampleData)
import Types exposing (..)



-- MAIN


main : Program () Model Msg
main =
    Browser.document
        { init = init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }



-- MODEL


type alias Model =
    { graph : Graph
    , hoveringId : Maybe Graph.NodeId
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( { graph = sampleData, hoveringId = Nothing }, Cmd.none )



-- UPDATE


type Msg
    = Hover { enter : Bool, id : Graph.NodeId }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Hover { enter, id } ->
            ( { model
                | hoveringId =
                    if enter then
                        Just id

                    else
                        Nothing
              }
            , Cmd.none
            )



-- VIEW


view : Model -> Browser.Document Msg
view model =
    { title = "MoneyMap"
    , body =
        [ CollageRender.svgBox ( 1500, 1500 ) (draw model)
        ]
    }


draw : Model -> Collage Msg
draw model =
    let
        nodes =
            List.map (drawNode model) (Graph.nodes model.graph)

        edges =
            List.map (drawEdge model) (Graph.edges model.graph)
    in
    CollageLayout.stack (nodes ++ edges)


drawEdge : Model -> Graph.Edge EdgeLabel -> Collage Msg
drawEdge model { from, to, label } =
    let
        { money } =
            label

        fromNode =
            Graph.get from model.graph

        toNode =
            Graph.get to model.graph
    in
    case ( fromNode, toNode ) of
        ( Just f, Just t ) ->
            segment (Point2d.coordinates f.node.label.position) (Point2d.coordinates t.node.label.position)
                |> traced (dot thick (uniform yellow))

        _ ->
            group []


drawNode : Model -> Graph.Node NodeLabel -> Collage Msg
drawNode { hoveringId } { label, id } =
    let
        { position, entity, name } =
            label
    in
    CollageLayout.stack <|
        [ (case entity of
            Politician data ->
                drawPolitician data

            _ ->
                rectangle 10.0 10.0
                    |> filled (uniform grey)
          )
            |> shift (Point2d.coordinates label.position)
            |> CollageEvents.onMouseEnter (\_ -> Hover { enter = True, id = id })
            |> CollageEvents.onMouseLeave (\_ -> Hover { enter = False, id = id })
        ]
            ++ (case hoveringId of
                    Just nodeId ->
                        if nodeId == id then
                            [ CollageText.fromString name
                                |> CollageText.shape CollageText.Italic
                                |> CollageText.size CollageText.huge
                                |> rendered
                                |> shift (Point2d.coordinates label.position)
                                |> shift ( 10.0, -25.0 )
                            ]

                        else
                            []

                    Nothing ->
                        []
               )


drawPolitician : PoliticianData -> Collage Msg
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
