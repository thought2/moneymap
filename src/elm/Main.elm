module Main exposing (main)

import App
import App.Types exposing (Model, Msg)
import App.View
import Browser



-- MAIN


main : Program () Model Msg
main =
    Browser.document
        { init = App.init
        , view = App.View.view
        , update = App.update
        , subscriptions = App.subscriptions
        }
