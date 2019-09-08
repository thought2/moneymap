module Components.Header.View exposing (view)

import Components exposing (dataModule)
import Components.Header.Styles as Styles
import Components.Header.Types exposing (Config)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (css)


moduleName : String
moduleName =
    "Components.Header.View"


view : Config -> Html msg
view config =
    div [ dataModule moduleName, css Styles.top ]
        [ text config.title
        ]
