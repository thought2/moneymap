port module Ports exposing (getLayout, setLayout)

import MoneyGraph exposing (GraphLayout)


port setLayout : () {- GraphLayout -} -> Cmd msg


port getLayout : (GraphLayout -> msg) -> Sub msg
