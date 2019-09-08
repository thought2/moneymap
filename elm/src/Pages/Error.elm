module Pages.Error exposing (viewDoc)

import Browser exposing (Document)
import Html.Styled exposing (text)
import PageTemplate


type alias Config =
    { msg : String }


viewDoc : Config -> Document msg
viewDoc config =
    PageTemplate.viewDoc
        { subTitle = "Error"
        , mainContent = text <| "Error: " ++ config.msg
        }
