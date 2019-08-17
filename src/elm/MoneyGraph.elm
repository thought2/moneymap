module MoneyGraph exposing (EdgeLabel, GraphLayout, MoneyGraph, NodeLabel, SimpleVector)

-- Graph

import CommonTypes exposing (Entity)
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


type alias SimpleVector =
    ( Float, Float )


type alias GraphLayout =
    { nodes :
        List
            { id : Graph.NodeId
            , position : SimpleVector
            , size : SimpleVector
            }
    , edges :
        List
            { fromId : Graph.NodeId
            , toId : Graph.NodeId
            , points : List SimpleVector
            }
    }
