module App.Types exposing (Model, Msg(..))

import Graph
import MoneyGraph exposing (GraphLayout, MoneyGraph)


type alias Model =
    { graph : MoneyGraph
    , hoveringId : Maybe Graph.NodeId
    }


type Msg
    = Hover { enter : Bool, id : Graph.NodeId }
    | GotLayout GraphLayout
