module Main exposing (..)

import Browser
import Graph
import Collage.Render as CollageRender
import Collage exposing (..)

import SampleData exposing (..)
import Model exposing (..)
import Draw exposing (..)

main : Program () Model Msg
main =
    Browser.document
        { init = init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }



init _ =
    ( { graph = sampleData, hoveringId = Nothing }, Cmd.none )


view : Model -> Browser.Document Msg
view model =
    { title = "MoneyMap"
    , body =
        [ CollageRender.svgBox ( 1500, 1500 ) (draw model)
        ]
    }

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    let cmd = Cmd.none
        updatedModel = 
          case msg of
            Hover { enter, id } ->
                ( { model
                    | hoveringId =
                        if enter then
                            Just id
                        else
                            Nothing
                  })
    in
      (updatedModel, cmd)