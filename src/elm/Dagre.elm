port module Dagre exposing (Input, Output, getLayout, setLayout)

-- import Graph exposing (NodeId)


type alias NodeId =
    String


type alias Size =
    { width : Float, height : Float }


type alias Point =
    { x : Float, y : Float }


type alias Input =
    { nodes :
        List
            { id : NodeId
            , data : Size
            }
    , edges :
        List
            { from : NodeId
            , to : NodeId
            }
    }


type alias Output =
    { nodes :
        List
            { id : NodeId
            , data : Point
            }
    , edges :
        List
            { from : NodeId
            , to : NodeId
            , data : { points : List Point }
            }
    }



-- PORTS


port setLayout : Input -> Cmd msg


port getLayout : (Output -> msg) -> Sub msg
