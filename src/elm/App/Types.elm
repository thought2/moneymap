module App.Types exposing (Model, Msg(..))

import Dagre
import Graph
import MoneyGraph exposing (MoneyGraph)


type alias Model =
    { graph : MoneyGraph
    , hoveringId : Maybe Graph.NodeId
    }


type Msg
    = Hover { enter : Bool, id : Graph.NodeId }
    | GotLayout Dagre.Output
