port module Dagre exposing (Input, InputEdge, InputNode, NodeId, Output, OutputEdge, OutputNode, Point, Size, getLayout, pointFromVector2d, setLayout, sizeFromVector2d)

-- import Graph exposing (NodeId)

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
    { id : NodeId
    , layout : Point
    }


type alias OutputEdge =
    { from : NodeId
    , to : NodeId
    , layout : { points : List Point }
    }


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
