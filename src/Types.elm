module Types exposing (Edge, Entity(..), Graph, Node, Organ(..), Party(..), PoliticianData)

import Graph
import Point2d exposing (Point2d)


type alias Graph =
    Graph.Graph Node Edge


type Party
    = Democrat
    | Republican


type Organ
    = House
    | Senate


type alias Node =
    { name : String
    , entity : Entity
    , position : Point2d
    }


type Entity
    = Politician PoliticianData
    | Company
    | PAC
    | Individual


type alias PoliticianData =
    { party : Party
    , organ : Organ
    }


type alias Edge =
    { money : Int }
