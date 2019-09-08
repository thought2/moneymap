module Main exposing (main)

import App
import Browser
import Html.Styled exposing (toUnstyled)



-- MAIN


main : Program () App.Model App.Msg
main =
    Browser.document
        { init = \_ -> App.init
        , view = App.view
        , update = App.update
        , subscriptions = App.subscriptions
        }
