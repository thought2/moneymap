module Pages.Main exposing (Config, Model, viewDoc)

import Browser exposing (Document)
import Html.Styled exposing (text)
import MoneyGraph exposing (MoneyGraph)
import MoneyGraph.Data exposing (MoneyGraphData)
import PageTemplate


type alias Model =
    { data : MoneyGraphData
    , visualGraph : MoneyGraph
    }


type alias Config =
    {}


init : MoneyGraphData -> Model
init =
    Debug.todo ""


viewDoc : Config -> Document msg
viewDoc config =
    PageTemplate.viewDoc
        { subTitle = "Main"
        , mainContent = text "main"
        }
