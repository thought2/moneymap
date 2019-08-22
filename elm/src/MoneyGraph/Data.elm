module MoneyGraph.Data exposing (EdgeLabel, MoneyGraphData, NodeLabel)

-- Graph

import CommonTypes exposing (Entity)
import Graph exposing (Edge, Graph, Node, NodeId)



-- Graph


type alias MoneyGraphData =
    Graph NodeLabel EdgeLabel



-- Node


type alias NodeLabel =
    { entity : Entity
    }



-- Edge


type alias EdgeLabel =
    { money : Int
    }
