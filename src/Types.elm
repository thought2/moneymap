module Types exposing (EdgeLabel, Entity(..), Graph, NodeLabel, Organ(..), Party(..), PoliticianData)

import Graph
import Point2d exposing (Point2d)


type Party
    = Democrat
    | Republican


type Organ
    = House
    | Senate


type Entity
    = Politician PoliticianData
    | Company
    | PAC
    | Individual


type alias PoliticianData =
    { party : Party
    , organ : Organ
    }



-- Graph labels


type alias Graph =
    Graph.Graph NodeLabel EdgeLabel


type alias NodeLabel =
    { name : String
    , entity : Entity
    , position : Point2d
    }


type alias EdgeLabel =
    { money : Int }
