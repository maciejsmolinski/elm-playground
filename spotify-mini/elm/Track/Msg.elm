module Track.Msg exposing (Msg(..))

import Track.Model exposing (Track)


type Msg
    = NoOp
    | PlayTrack Track
