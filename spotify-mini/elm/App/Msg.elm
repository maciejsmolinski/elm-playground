module App.Msg exposing (Msg(..))

import TrackList.Msg as TrackList


type Msg
    = NoOp
    | TrackList TrackList.Msg
    | UpdateSearch String
