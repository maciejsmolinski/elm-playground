module App.Msg exposing (Msg(..))

import Track.Model exposing (Track)
import TrackList.Msg as TrackList


type Msg
    = NoOp
    | TrackList TrackList.Msg
    | UpdateSearch String
    | PlayTrack Track
