module TrackList.Msg exposing (Msg(..))

import TrackList.Model exposing (TrackList)
import Track.Msg as Track


type Msg
    = NoOp
    | ClearTrackList
    | UpdateTrackList TrackList
    | Track Track.Msg
