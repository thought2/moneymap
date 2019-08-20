module Dagre.Ports exposing (getLayout, setLayout)

-- API

import Dagre.LowLevel exposing (Input, Output)


port setLayout : Input -> Cmd msg


port getLayout : (Output -> msg) -> Sub msg
