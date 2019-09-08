module Components.Header exposing (Config, view)

import Html.Styled exposing (..)


type alias Config =
    { title : String }


view : Config -> Html msg
view config =
    div [] [ text config.title ]
