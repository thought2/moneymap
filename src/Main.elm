module Main exposing (init, main, update, view)

import Browser
import Collage exposing (..)
import Collage.Events as CollageEvents
import Collage.Layout as CollageLayout
import Collage.Render as CollageRender
import Collage.Text as CollageText
import Color exposing (..)
import Draw exposing (draw)
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


init : () -> ( Model, Cmd Msg )
init _ =
    ( { graph = sampleData, hoveringId = Nothing }, Cmd.none )



-- UPDATE


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
