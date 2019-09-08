module Components.Content exposing (Config, view)

import Data.Settings as Settings exposing (Settings)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (type_, value)
import Html.Styled.Events exposing (..)
import MoneyGraph exposing (MoneyGraph)


type alias Model =
    { graph : String
    }


type Msg
    = ChangeGraph String


type alias Config msg =
    { settings : Settings
    , graph : MoneyGraph
    , onMsg : Msg -> msg
    , onSettingsChange : Settings -> msg
    }


update : Msg -> Model -> ( Model, Cmd Msg )
update _ m =
    ( m, Cmd.none )


view : Config msg -> Model -> Html msg
view config model =
    div []
        [ text "MAIN CONTENT"
        , button [ onClick <| config.onSettingsChange <| Settings.toggleOn config.settings ]
            [ text "toggle" ]
        , text <| Debug.toString config.settings
        , input
            [ type_ "text"
            , value model.graph
            , onInput <| ChangeGraph >> config.onMsg
            ]
            []
        ]
