module Main exposing (main)

import Browser
import GraphExplorer
import GraphExplorer.Types exposing (Model, Msg)
import GraphExplorer.View



-- MAIN


main : Program () Model Msg
main =
    Browser.document
        { init = GraphExplorer.init
        , view = GraphExplorer.View.view
        , update = GraphExplorer.update
        , subscriptions = GraphExplorer.subscriptions
        }
