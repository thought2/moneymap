module App exposing (init, subscriptions, update)

import App.Types exposing (Model, Msg(..))
import Dagre
import MoneyGraph exposing (MoneyGraph)
import SampleData exposing (sampleData)



-- MODEL


init : () -> ( Model, Cmd Msg )
init _ =
    ( initModel
    , initCmd initModel
    )


initCmd : Model -> Cmd Msg
initCmd model =
    Cmd.batch
        [ Dagre.setLayout (MoneyGraph.toDagre model.graph)
        ]


initModel : Model
initModel =
    { graph = initGraph
    , hoveringId = Nothing
    }


initGraph : MoneyGraph
initGraph =
    MoneyGraph.fromData sampleData



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Hover { enter, id } ->
            ( { model
                | hoveringId =
                    if enter then
                        Just id

                    else
                        Nothing
              }
            , Cmd.none
            )

        NoOp ->
            ( model, Cmd.none )

        GotLayout dagreGraph ->
            ( { model
                | graph =
                    MoneyGraph.updateWithDagre dagreGraph model.graph
                        |> Maybe.withDefault model.graph
              }
            , Cmd.none
            )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    Dagre.getLayout GotLayout
