module MoneyGraph.Visual exposing (EdgeLabel, GraphLabel, NodeLabel, defaultEdgeLabel, defaultGraphLabel, defaultNodeLabel)

import Vector2d exposing (Vector2d)


type alias GraphLabel =
    { size : Vector2d
    }


type alias NodeLabel =
    { position : Vector2d
    , size : Vector2d
    }


type alias EdgeLabel =
    { points : List Vector2d
    }



-- Defaults


defaultGraphLabel : GraphLabel
defaultGraphLabel =
    { size = Vector2d.fromComponents ( 0.0, 0.0 )
    }


defaultNodeLabel : NodeLabel
defaultNodeLabel =
    { position = Vector2d.zero
    , size = Vector2d.fromComponents ( 10.0, 10.0 )
    }


defaultEdgeLabel : EdgeLabel
defaultEdgeLabel =
    { points = [] }
