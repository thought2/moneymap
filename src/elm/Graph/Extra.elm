module Graph.Extra exposing (getEdge, getNode)

import Graph exposing (Edge, Graph, Node, NodeId)
import IntDict


getEdge : { from : NodeId, to : NodeId } -> Graph n e -> Maybe e
getEdge { from, to } graph =
    Graph.get from graph
        |> Maybe.andThen (\{ outgoing } -> IntDict.get to outgoing)


getNode : NodeId -> Graph n e -> Maybe n
getNode id graph =
    Graph.get id graph
        |> Maybe.map (.node >> .label)
