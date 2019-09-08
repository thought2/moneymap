module App exposing (Model, Msg(..), init, subscriptions, update, view)

import Browser exposing (Document)
import Html exposing (Attribute, Html, div, input, text)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import MoneyGraph exposing (MoneyGraph)
import MoneyGraph.Data exposing (MoneyGraphData)
import Pages.Error
import Pages.Idle
import Pages.Loading
import Pages.Main
import RemoteData as RemoteData exposing (WebData)



-- MODEL


type alias Model =
    { main : WebData MoneyGraphData
    }


init : ( Model, Cmd Msg )
init =
    ( { main = RemoteData.NotAsked }
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
        RemoteData.NotAsked ->
            Pages.Idle.viewDoc

        RemoteData.Loading ->
            Pages.Loading.viewDoc

        RemoteData.Failure e ->
            -- TODO: Better error message
            Pages.Error.viewDoc { msg = "some error" }

        RemoteData.Success data ->
            Pages.Main.viewDoc
                {}
                (Pages.Main.init data)


subscriptions _ =
    Sub.none
