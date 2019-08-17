module CommonTypes exposing (Entity(..), Organ(..), Party(..), PoliticianData)

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
