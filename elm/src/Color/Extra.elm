module Color.Extra exposing (toCssColor)

import Color
import Css


toCssColor : Color.Color -> Css.Color
toCssColor color =
    let
        { hue, saturation, lightness, alpha } =
            Color.toHsla color
    in
    Css.hsla hue saturation lightness alpha
