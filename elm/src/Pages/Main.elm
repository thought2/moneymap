module Pages.Main exposing (Config, Model, init, viewDoc)

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
init _ =
    Debug.todo ""


viewDoc : Config -> Model -> Document msg
viewDoc config model =
    PageTemplate.viewDoc
        { subTitle = "Main"
        , mainContent = text ""
        }
