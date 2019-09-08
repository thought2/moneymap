module Components.Header.Styles exposing (top)

import Color.Extra exposing (toCssColor)
import ColorPalette
import Css exposing (..)


top : List Style
top =
    [ backgroundColor <| toCssColor ColorPalette.dark
    , color <| toCssColor ColorPalette.light
    ]
