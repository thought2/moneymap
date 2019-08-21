port module Dagre.LowLevel.Ports exposing (getLayout, setLayout)

import Dagre.LowLevel.Input as LowLevelInput
import Dagre.LowLevel.Output as LowLevelOutput


port setLayout : LowLevelInput.Graph -> Cmd msg


port getLayout : (LowLevelOutput.Graph -> msg) -> Sub msg
