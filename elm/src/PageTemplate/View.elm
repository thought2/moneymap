module PageTemplate.View exposing (view)

import Html.Styled as Html exposing (..)
import PageTemplate.Types exposing (..)


view : Config msg -> Html msg
view config =
    div []
        [ div []
            [ h1 [] [ text "header" ]
            , text config.subTitle
            ]
        , div []
            [ h1 [] [ text "main" ]
            , config.mainContent
            ]
        ]
