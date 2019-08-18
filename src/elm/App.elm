module App exposing (init, subscriptions, update, view)

import App.Draw exposing (draw)
import App.Types exposing (Model, Msg(..))
import Browser
import Collage.Render as CollageRender
import Dagre
import Graph
import LayoutedGraph
import LayoutedGraph.Dagre as LayoutedGraphDagre
import LayoutedMoneyGraph exposing (LayoutedMoneyGraph)
import SampleData exposing (sampleData)



-- MODEL


init : () -> ( Model, Cmd Msg )
init _ =
    ( initModel
    , LayoutedGraphDagre.setLayout
        (initGraph |> LayoutedMoneyGraph.toLayoutedGraph)
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
            (\data ->
                { data = data
                , layout = LayoutedGraph.defaultNodeLabel
                }
            )
        |> Graph.mapEdges
            (\data ->
                { data = data
                , layout = LayoutedGraph.defaultEdgeLabel
                }
            )



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

        GotLayout layout ->
            ( { model
                | graph =
                    LayoutedMoneyGraph.updateLayout layout model.graph
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



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    LayoutedGraphDagre.getLayout (\_ -> NoOp)
