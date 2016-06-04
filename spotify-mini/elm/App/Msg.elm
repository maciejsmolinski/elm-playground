module App.Msg exposing (Msg(..))

import TrackList.Msg as TrackList
import Search.Msg as Search


type Msg
    = NoOp
    | TrackList TrackList.Msg
    | Search Search.Msg
