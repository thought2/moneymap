module App.Types exposing (Model, Msg(..))

import Graph
import LayoutedGraph exposing (LayoutedGraph)
import LayoutedMoneyGraph exposing (LayoutedMoneyGraph)


type alias Model =
    { graph : LayoutedMoneyGraph
    , hoveringId : Maybe Graph.NodeId
    }


type Msg
    = Hover { enter : Bool, id : Graph.NodeId }
    | GotLayout LayoutedGraph
