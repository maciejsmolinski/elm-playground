module App.Action exposing (Action(..))

import TrackList.Model exposing (TrackList)

type Action
  = NoOp
  | UpdateTrackList TrackList
