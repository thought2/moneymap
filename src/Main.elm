module Main exposing (init, main, update, view)

import Browser
import Collage.Render as CollageRender
import Draw exposing (draw)
import Ports
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
    ( initModel
    , Cmd.none
      --, Ports.setLayout
    )


initModel : Model
initModel =
    { graph = sampleData
    , hoveringId = Nothing
    }



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

        GotLayout layout ->
            ( model, Cmd.none )



-- VIEW


view : Model -> Browser.Document Msg
view model =
    { title = "MoneyMap"
    , body =
        [ CollageRender.svgBox ( 1500, 1500 ) (draw model)
        ]
    }
