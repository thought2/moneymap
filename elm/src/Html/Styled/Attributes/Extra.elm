module Html.Styled.Attributes.Extra exposing (data)

import Html.Attributes exposing (attribute)
import Html.Styled exposing (Attribute)


data : String -> String -> Attribute msg
data key value =
    attribute (data ++ "-" ++ key) value
