module Model exposing (..)

import Point2d exposing (Point2d)
import Graph


-- Model
type alias Graph =
    Graph.Graph Node Edge


type alias Model =
    { graph : Graph
    , hoveringId : Maybe Graph.NodeId
    , viewBox :
        { position : Point2d
        , size : Point2d
        }
    }


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




-- Update

type Msg
    = Hover { enter : Bool, id : Graph.NodeId }
