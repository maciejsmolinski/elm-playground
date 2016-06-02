module App.Msg exposing (Msg(..))

import TrackList.Model exposing (TrackList)
import Track.Model exposing (Track)


type Msg
    = NoOp
    | ClearTrackList
    | UpdateTrackList TrackList
    | UpdateSearch String
    | PlayTrack Track
