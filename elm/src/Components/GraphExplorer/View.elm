module GraphExplorer.View exposing (view)

-- VIEW

import Browser
import Collage.Render as CollageRender
import GraphExplorer.Draw exposing (draw)
import GraphExplorer.Types exposing (Model, Msg)


view : Model -> Browser.Document Msg
view model =
    { title = "MoneyMap"
    , body =
        -- TODO: Use the real size from Dagre and make the SVG responsive
        [ CollageRender.svgBox ( 1500, 1500 ) (draw model)
        ]
    }
