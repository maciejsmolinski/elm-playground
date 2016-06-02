module App.Action exposing (Action(..))

import TrackList.Model exposing (TrackList)
import Track.Model exposing (Track)


type Action
    = NoOp
    | ClearTrackList
    | UpdateTrackList TrackList
    | UpdateSearch String
    | PlayTrack Track
