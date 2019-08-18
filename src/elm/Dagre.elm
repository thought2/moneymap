port module Dagre exposing (Input, InputEdge, InputNode, NodeId, Output, OutputEdge, OutputNode, Point, Size, getLayout, pointFromVector2d, pointToVector2d, setLayout, sizeFromVector2d, sizeToVector2d)

import Vector2d as Vector2d exposing (Vector2d)


type alias NodeId =
    String


type alias Size =
    { width : Float, height : Float }


type alias Point =
    { x : Float, y : Float }



-- INPUT


type alias InputNode =
    { id : NodeId
    , layout : Size
    }


type alias InputEdge =
    { from : NodeId
    , to : NodeId
    }


type alias Input =
    { nodes : List InputNode
    , edges : List InputEdge
    }



-- OUTPUT


type alias OutputNode =
    ( NodeId, Point )


type alias OutputEdge =
    ( ( NodeId, NodeId ), List Point )


type alias Output =
    { nodes : List OutputNode
    , edges : List OutputEdge
    }



-- PORTS


port setLayout : Input -> Cmd msg


port getLayout : (Output -> msg) -> Sub msg



-- UTILS


sizeFromVector2d : Vector2d -> Size
sizeFromVector2d vec =
    { width = Vector2d.xComponent vec
    , height = Vector2d.yComponent vec
    }


pointFromVector2d : Vector2d -> Point
pointFromVector2d vec =
    { x = Vector2d.xComponent vec
    , y = Vector2d.yComponent vec
    }


pointToVector2d : Point -> Vector2d
pointToVector2d { x, y } =
    Vector2d.fromComponents ( x, y )


sizeToVector2d : Size -> Vector2d
sizeToVector2d { width, height } =
    Vector2d.fromComponents ( width, height )
