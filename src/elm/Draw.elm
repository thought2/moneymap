module Draw exposing (draw, drawEdge, drawNode, drawPolitician)

import Collage exposing (..)
import Collage.Events exposing (..)
import Collage.Layout exposing (..)
import Collage.Text as CollageText
import Color exposing (..)
import Graph
import Point2d
import Types exposing (EdgeLabel, Entity(..), Model, Msg(..), NodeLabel, Party(..), PoliticianData)


draw : Model -> Collage Msg
draw ({ graph } as model) =
    let
        nodes =
            List.map (drawNode model) (Graph.nodes graph)

        edges =
            List.map (drawEdge model) (Graph.edges graph)
    in
    stack (nodes ++ edges)


drawEdge : Model -> Graph.Edge EdgeLabel -> Collage Msg
drawEdge model { from, to } =
    let
        maybeFromNode =
            Graph.get from model.graph

        maybeToNode =
            Graph.get to model.graph
    in
    case ( maybeFromNode, maybeToNode ) of
        ( Just fromNode, Just toNode ) ->
            segment
                (Point2d.coordinates fromNode.node.label.position)
                (Point2d.coordinates toNode.node.label.position)
                |> traced (dot thick (uniform yellow))

        _ ->
            empty


drawNode : Model -> Graph.Node NodeLabel -> Collage Msg
drawNode { hoveringId } ({ id } as node) =
    stack <|
        [ drawDot node
        , case hoveringId of
            Just nodeId ->
                if nodeId == id then
                    drawText node

                else
                    empty

            Nothing ->
                empty
        ]


drawDot : Graph.Node NodeLabel -> Collage Msg
drawDot { label, id } =
    let
        { entity } =
            label
    in
    (case entity of
        Politician data ->
            drawPolitician data

        _ ->
            rectangle 10.0 10.0
                |> filled (uniform grey)
    )
        |> shift (Point2d.coordinates label.position)
        |> onMouseEnter (\_ -> Hover { enter = True, id = id })
        |> onMouseLeave (\_ -> Hover { enter = False, id = id })


drawText : Graph.Node NodeLabel -> Collage Msg
drawText { label } =
    let
        { name } =
            label
    in
    CollageText.fromString name
        |> CollageText.shape CollageText.Italic
        |> CollageText.size CollageText.huge
        |> rendered
        |> shift (Point2d.coordinates label.position)
        |> shift ( 10.0, -25.0 )


drawPolitician : PoliticianData -> Collage Msg
drawPolitician { party } =
    let
        color =
            case party of
                Democrat ->
                    blue

                Republican ->
                    red
    in
    circle 10.0
        |> filled (uniform color)
