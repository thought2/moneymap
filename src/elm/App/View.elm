module App.View exposing (view)

-- VIEW

import App.Draw exposing (draw)
import App.Types exposing (Model, Msg)
import Browser
import Collage.Render as CollageRender


view : Model -> Browser.Document Msg
view model =
    { title = "MoneyMap"
    , body =
        [ CollageRender.svgBox ( 1500, 1500 ) (draw model)
        ]
    }
