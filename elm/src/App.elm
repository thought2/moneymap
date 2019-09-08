module App exposing (Model, Msg(..), init, subscriptions, update, view)

import Browser exposing (Document)
import Html exposing (Attribute, Html, div, input, text)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import MoneyGraph exposing (MoneyGraph)
import MoneyGraph.Data exposing (MoneyGraphData)
import Pages.Loading
import Pages.Main



-- MODEL


type alias Model =
    { main : Maybe Pages.Main.Model
    }


init : ( Model, Cmd Msg )
init =
    ( { main = Nothing }
    , Cmd.none
    )



-- UPDATE


type Msg
    = Change String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )



-- VIEW


view : Model -> Document Msg
view model =
    case model.main of
        Nothing ->
            Pages.Loading.viewDoc

        Just data ->
            Pages.Main.viewDoc
                {}


subscriptions _ =
    Sub.none
