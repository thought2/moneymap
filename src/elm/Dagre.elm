port module Dagre exposing (Input, Output, getLayout, setLayout)

import Graph


type alias Size =
    { width : Float, height : Float }


type alias Point =
    { x : Float, y : Float }


type alias Input =
    { nodes :
        List
            { id : Graph.NodeId
            , data : Size
            }
    , edges :
        List
            { from : Graph.NodeId
            , to : Graph.NodeId
            }
    }


type alias Output =
    { nodes :
        List
            { id : Graph.NodeId
            , data : Point
            }
    , edges :
        List
            { from : Graph.NodeId
            , to : Graph.NodeId
            , data : { points : List Point }
            }
    }



-- PORTS


port setLayout : () {- GraphLayout -} -> Cmd msg


port getLayout : (Output -> msg) -> Sub msg
