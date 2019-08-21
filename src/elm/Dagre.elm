module Dagre exposing (getLayout, setLayout)

import Dagre.Input as Input
import Dagre.LowLevel.Ports as Ports
import Dagre.Output as Output


setLayout : Input.Graph -> Cmd msg
setLayout graph =
    Ports.setLayout <| Input.toLowLevel graph


getLayout : (Output.Graph -> msg) -> Sub msg
getLayout f =
    Ports.getLayout (Output.fromLowLevel >> f)
