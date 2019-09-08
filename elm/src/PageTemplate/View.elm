module PageTemplate.View exposing (view)

import Components.Header.View
import Html.Styled as Html exposing (..)
import PageTemplate.Types exposing (..)


view : Config msg -> Html msg
view config =
    div []
        [ Components.Header.View.view { title = "moneymap " ++ config.subTitle }
        , div []
            [ h1 [] [ text "main" ]
            , config.mainContent
            ]
        ]
