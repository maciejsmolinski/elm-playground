module App.Action exposing (Action(..))

import TrackList.Model exposing (TrackList)


type Action
    = NoOp
    | ClearTrackList
    | UpdateTrackList TrackList
    | UpdateSearch String
