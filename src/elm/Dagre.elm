module Dagre exposing (getLayout, setLayout)

import Dagre.Input as Input
import Dagre.LowLevel.Input
import Dagre.LowLevel.Output
import Dagre.Output as Output



-- TODO: Add documentation of the purpose of this module
-- TODO: Add documentation for the functions
-- TODO: Publish as a library and remove from project


setLayout : Input.Graph -> Cmd msg
setLayout graph =
    Dagre.LowLevel.Input.setLayout <| Input.toLowLevel graph


getLayout : (Output.Graph -> msg) -> Sub msg
getLayout f =
    Dagre.LowLevel.Output.getLayout (Output.fromLowLevel >> f)
