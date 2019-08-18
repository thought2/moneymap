module Main exposing (..)

import Browser
import Collage.Render as CollageRender

import Point2d
import SampleData exposing (..)
import Svg.Attributes exposing (width, height, viewBox)
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
    ( { graph = sampleData
       , hoveringId = Nothing
       , viewBox =
        { position =  Point2d.fromCoordinates ( -750.0, -750.0 )
        , size =  Point2d.fromCoordinates ( 1500.0, 1500.0 )
        }
      }, Cmd.none )


view : Model -> Browser.Document Msg
view model =
    { title = "MoneyMap"
    , body =
        [ CollageRender.svgExplicit
            [ width "1500px"
            , height "1500px"
            , viewBox "-750 -750 1500 1500" ]
            (draw model)
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
