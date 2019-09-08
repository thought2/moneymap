module Pages.Idle exposing (viewDoc)

import Browser exposing (Document)
import Html.Styled exposing (text)
import PageTemplate


viewDoc : Document msg
viewDoc =
    PageTemplate.viewDoc
        { subTitle = ""
        , mainContent = text "idle"
        }
