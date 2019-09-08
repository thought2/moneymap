module Components exposing (dataModule)

import Html.Styled exposing (Attribute)
import Html.Styled.Attributes exposing (attribute)


data : String -> String -> Attribute msg
data key value =
    attribute (key ++ "-" ++ key) value


dataModule : String -> Attribute msg
dataModule value =
    data "module" value
