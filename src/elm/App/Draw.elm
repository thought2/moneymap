module App.Draw exposing (draw)

import App.Types exposing (Model, Msg(..))
import Collage exposing (..)
import Collage.Events exposing (..)
import Collage.Layout exposing (..)
import Collage.Text as CollageText
import Color exposing (..)
import CommonTypes exposing (Entity(..), Party(..), PoliticianData)
import Graph
import MoneyGraph exposing (EdgeLabel, NodeLabel)
import Point2d
import Vector2d


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
            Maybe.map .node <| Graph.get from model.graph

        maybeToNode =
            Maybe.map .node <| Graph.get to model.graph
    in
    case ( maybeFromNode, maybeToNode ) of
        ( Just fromNode, Just toNode ) ->
            segment
                (Vector2d.components fromNode.label.layout.position)
                (Vector2d.components toNode.label.layout.position)
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
        { data, layout } =
            label
    in
    drawEntity data.entity
        |> shift (Vector2d.components layout.position)
        |> onMouseEnter (\_ -> Hover { enter = True, id = id })
        |> onMouseLeave (\_ -> Hover { enter = False, id = id })


drawEntity : Entity -> Collage Msg
drawEntity entity =
    case entity of
        Politician data ->
            drawPolitician data

        _ ->
            rectangle 10.0 10.0
                |> filled (uniform grey)


drawText : Graph.Node NodeLabel -> Collage Msg
drawText { label } =
    let
        { data, layout } =
            label
    in
    CollageText.fromString data.name
        |> CollageText.shape CollageText.Italic
        |> CollageText.size CollageText.huge
        |> rendered
        |> shift (Vector2d.components layout.position)
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
