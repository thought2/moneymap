module MoneyGraph exposing (EdgeLabel, MoneyGraph, NodeLabel)

-- Graph

import CommonTypes exposing (Entity)
import Graph exposing (Edge, Graph, Node, NodeId)



-- Graph


type alias MoneyGraph =
    Graph NodeLabel EdgeLabel



-- Node


type alias NodeLabel =
    { entity : Entity
    }



-- Edge


type alias EdgeLabel =
    { money : Int
    }
