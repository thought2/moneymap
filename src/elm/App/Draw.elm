module App.Draw exposing (draw)

import App.Types exposing (Model, Msg(..))
import Collage exposing (..)
import Collage.Events exposing (..)
import Collage.Layout exposing (..)
import Collage.Text as CollageText
import Color exposing (..)
import CommonTypes exposing (Entity(..), Party(..), Politician, toEntityCommon)
import Graph
import LayoutedMoneyGraph
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


drawNode : Model -> LayoutedMoneyGraph.Node -> Collage Msg
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


drawDot : LayoutedMoneyGraph.Node -> Collage Msg
drawDot { label, id } =
    let
        { data, layout } =
            label
    in
    drawEntity data.entity
        |> shift (Vector2d.components layout.position)
        |> onMouseEnter (\_ -> Hover { enter = True, id = id })
        |> onMouseLeave (\_ -> Hover { enter = False, id = id })


drawEdge : Model -> LayoutedMoneyGraph.Edge -> Collage Msg
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


drawEntity : Entity -> Collage Msg
drawEntity entity =
    case entity of
        EntityPolitician data ->
            drawPolitician data

        _ ->
            rectangle 10.0 10.0
                |> filled (uniform grey)


drawText : LayoutedMoneyGraph.Node -> Collage Msg
drawText { label } =
    let
        { data, layout } =
            label

        entityCommon =
            toEntityCommon data.entity
    in
    CollageText.fromString entityCommon.name
        |> CollageText.shape CollageText.Italic
        |> CollageText.size CollageText.huge
        |> rendered
        |> shift (Vector2d.components layout.position)
        |> shift ( 10.0, -25.0 )


drawPolitician : Politician -> Collage Msg
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
