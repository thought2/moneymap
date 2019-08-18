module Entity exposing (Entity(..))


type Entity
    = Politician Politician
    | Company
    | PAC
    | Individual


type alias Politician =
    { a : Int }
