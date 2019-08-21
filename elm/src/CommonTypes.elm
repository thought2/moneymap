module CommonTypes exposing (Entity(..), Organ(..), Party(..), Politician, toEntityCommon)

-- Common


type Party
    = Democrat
    | Republican


type Organ
    = House
    | Senate


type Entity
    = EntityPolitician Politician
    | EntityCompany Company
    | EntityPAC PAC
    | EntityIndividual Individual


type alias Politician =
    { name : String
    , party : Party
    , organ : Organ
    }


type alias Company =
    { name : String
    }


type alias PAC =
    { name : String
    }


type alias Individual =
    { name : String
    }


type alias EntityCommon =
    { name : String
    }


toEntityCommon : Entity -> EntityCommon
toEntityCommon entity =
    case entity of
        EntityPolitician { name } ->
            { name = name }

        EntityCompany { name } ->
            { name = name }

        EntityPAC { name } ->
            { name = name }

        EntityIndividual { name } ->
            { name = name }
