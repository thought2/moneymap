module Data.Settings exposing (Settings, toggleOn)


type alias Settings =
    { on : Bool
    }


toggleOn : Settings -> Settings
toggleOn settings =
    { settings
        | on = not settings.on
    }
