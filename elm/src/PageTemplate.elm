module PageTemplate exposing (viewDoc)

import Browser exposing (Document)
import Html.Styled as Html
import PageTemplate.Types exposing (..)
import PageTemplate.View exposing (view)


viewDoc : Config msg -> Document msg
viewDoc config =
    { title = String.join " " [ "MoneyMap", "/", config.subTitle ]
    , body = [ Html.toUnstyled <| view config ]
    }
