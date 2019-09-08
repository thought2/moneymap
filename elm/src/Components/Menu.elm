module Components.Menu exposing (Config, view)

import Data.Settings as Settings exposing (Settings)
import Html.Styled exposing (..)
import Html.Styled.Events exposing (..)


type alias Config msg =
    { settings : Settings
    , onSettingsChange : Settings -> msg
    }


view : Config msg -> Html msg
view config =
    div []
        [ text "MENU"
        , button [ onClick <| config.onSettingsChange <| Settings.toggleOn config.settings ]
            [ text "toggle" ]
        , text <| Debug.toString config.settings
        ]
