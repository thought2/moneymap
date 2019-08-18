module App exposing (init, update, view)

import App.Draw exposing (draw)
import App.Types exposing (Model, Msg(..))
import Browser
import Collage.Render as CollageRender
import Dagre
import Graph
import MoneyGraph exposing (LayoutedMoneyGraph, defaultEdgeLayout, defaultNodeLayout)
import SampleData exposing (sampleData)



-- MODEL


init : () -> ( Model, Cmd Msg )
init _ =
    ( initModel
    , Dagre.setLayout (MoneyGraph.toDagreInput initModel.graph)
    )


initModel : Model
initModel =
    { graph = initGraph
    , hoveringId = Nothing
    }


initGraph : LayoutedMoneyGraph
initGraph =
    sampleData
        |> Graph.mapNodes
            (\data -> { data = data, layout = defaultNodeLayout })
        |> Graph.mapEdges
            (\data -> { data = data, layout = defaultEdgeLayout })



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

        GotLayout layout ->
            ( { model
                | graph =
                    MoneyGraph.updateLayout layout model.graph
                        |> Maybe.withDefault model.graph
              }
            , Cmd.none
            )



-- VIEW


view : Model -> Browser.Document Msg
view model =
    { title = "MoneyMap"
    , body =
        [ CollageRender.svgBox ( 1500, 1500 ) (draw model)
        ]
    }
