module Types exposing (EdgeLabel, Entity(..), Graph, GraphLayout, Model, Msg(..), NodeLabel, Organ(..), Party(..), PoliticianData)

import Graph
import Point2d exposing (Point2d)



-- App


type alias Model =
    { graph : Graph
    , hoveringId : Maybe Graph.NodeId
    }


type Msg
    = Hover { enter : Bool, id : Graph.NodeId }
    | GotLayout GraphLayout



-- Common


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



-- Graph


type alias Graph =
    Graph.Graph NodeLabel EdgeLabel


type alias NodeLabel =
    { name : String
    , entity : Entity
    , position : Point2d
    }


type alias EdgeLabel =
    { money : Int }


type alias SimpleVector =
    ( Float, Float )


type alias GraphLayout =
    { nodes :
        List
            { id : Graph.NodeId
            , position : SimpleVector
            , size : SimpleVector
            }
    , edges :
        List
            { fromId : Graph.NodeId
            , toId : Graph.NodeId
            , points : List SimpleVector
            }
    }
