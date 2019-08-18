module LayoutedGraph.Dagre exposing (getLayout, setLayout)

import Dagre
import Graph exposing (Edge, Node)
import LayoutedGraph exposing (LayoutedGraph)
import Vector2d exposing (Vector2d)


toDagreData : LayoutedGraph -> Dagre.Data
toDagreData graph =
    let
        makeNode { id, label } =
            { id = id
            , label =
                { width = Vector2d.xComponent label.size
                , height = Vector2d.yComponent label.size
                , x = Vector2d.xComponent label.position
                , y = Vector2d.yComponent label.position
                }
            }

        makeEdge { from, to, label } =
            { from = from
            , to = to
            , label =
                { points =
                    List.map
                        (\point ->
                            { x = Vector2d.xComponent point
                            , y = Vector2d.yComponent point
                            }
                        )
                        label.points
                }
            }
    in
    { nodes = List.map makeNode (Graph.nodes graph)
    , edges = List.map makeEdge (Graph.edges graph)
    }


fromDagreData : Dagre.Data -> LayoutedGraph
fromDagreData { nodes, edges } =
    let
        makeNode { id, label } =
            Node
                id
                { position =
                    Vector2d.fromComponents ( label.x, label.y )
                , size =
                    Vector2d.fromComponents ( label.width, label.height )
                }

        makeEdge { from, to, label } =
            Edge
                from
                to
                { points =
                    List.map
                        (\{ x, y } ->
                            Vector2d.fromComponents ( x, y )
                        )
                        label.points
                }
    in
    Graph.fromNodesAndEdges
        (List.map makeNode nodes)
        (List.map makeEdge edges)



--
--


setLayout : LayoutedGraph -> Cmd msg
setLayout =
    toDagreData >> Dagre.setLayout


getLayout : (LayoutedGraph -> msg) -> Sub msg
getLayout f =
    Dagre.getLayout (fromDagreData >> f)
