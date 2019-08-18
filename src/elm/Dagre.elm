port module Dagre exposing (Data, getLayout, setLayout)


type alias NodeId =
    Int


type alias Data =
    { nodes :
        List
            { id : NodeId
            , label :
                { width : Float
                , height : Float
                , x : Float
                , y : Float
                }
            }
    , edges :
        List
            { from : NodeId
            , to : NodeId
            , label :
                { points :
                    List
                        { x : Float
                        , y : Float
                        }
                }
            }
    }



-- API


port setLayout : Data -> Cmd msg


port getLayout : (Data -> msg) -> Sub msg
