module MoneyGraph exposing (EdgeLabel, MoneyGraph, NodeLabel)

-- Graph

import CommonTypes exposing (Entity)
import Dagre
import Graph exposing (Graph)
import Point2d exposing (Point2d)


type alias MoneyGraph =
    Graph NodeLabel EdgeLabel


type alias NodeLabel =
    { name : String
    , entity : Entity
    , position : Point2d
    }


type alias EdgeLabel =
    { money : Int }


toDagreInput : MoneyGraph -> Dagre.Input
toDagreInput =
    Debug.todo "toGraphLayout"


updateLayout : Dagre.Output -> MoneyGraph -> MoneyGraph
updateLayout =
    Debug.todo "updateLayout"
