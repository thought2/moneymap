module PageTemplate.Types exposing (Config, Model)

import Data.Settings exposing (Settings)
import Html.Styled exposing (Html)


type alias Model =
    { showMenu : Bool
    , settings : Settings
    }


type alias Config msg =
    { subTitle : String
    , mainContent : Html msg
    }
