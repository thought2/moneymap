module Pages.Loading exposing (viewDoc)

import Browser exposing (Document)
import Html.Styled exposing (text)
import PageTemplate


viewDoc : Document msg
viewDoc =
    PageTemplate.viewDoc
        { subTitle = "Loading"
        , mainContent = text "loading.."
        }
