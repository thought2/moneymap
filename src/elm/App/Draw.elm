module App.Draw exposing (draw)

import App.Types exposing (Model, Msg(..))
import Collage exposing (..)
import Collage.Events exposing (..)
import Collage.Layout exposing (..)
import Collage.Text as CollageText
import Color exposing (..)
import CommonTypes exposing (Entity(..), Party(..), Politician, toEntityCommon)
import Graph
import Graph.WithLabel as GraphWithLabel
import MoneyGraph
import Vector2d


draw : Model -> Collage Msg
draw model =
    let
        graph =
            model.graph.graph

        nodes =
            List.map (drawNode model) (Graph.nodes graph)

        edges =
            List.map (drawEdge model) (Graph.edges graph)
    in
    stack (nodes ++ edges)


drawNode : Model -> MoneyGraph.Node -> Collage Msg
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


drawDot : MoneyGraph.Node -> Collage Msg
drawDot { label, id } =
    let
        { data, layout } =
            label
    in
    drawEntity data.entity
        |> shift (Vector2d.components layout.position)
        |> onMouseEnter (\_ -> Hover { enter = True, id = id })
        |> onMouseLeave (\_ -> Hover { enter = False, id = id })


drawEdge : Model -> MoneyGraph.Edge -> Collage Msg
drawEdge model { from, to } =
    let
        maybeFromNode =
            Maybe.map .node <| Graph.get from model.graph.graph

        maybeToNode =
            Maybe.map .node <| Graph.get to model.graph.graph
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


drawText : MoneyGraph.Node -> Collage Msg
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
