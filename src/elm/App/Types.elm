module App.Types exposing (Model, Msg(..))

import Dagre
import Graph
import MoneyGraph exposing (LayoutedMoneyGraph, MoneyGraph)


type alias Model =
    { graph : LayoutedMoneyGraph
    , hoveringId : Maybe Graph.NodeId
    }


type Msg
    = Hover { enter : Bool, id : Graph.NodeId }
    | GotLayout Dagre.Output
