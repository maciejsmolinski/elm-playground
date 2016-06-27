module App.Msg exposing (Msg(..))

import TrackList.Msg as TrackList
import Search.Msg as Search
import Player.Msg as Player
import Routing.Msg as Routing


type Msg
    = NoOp
    | TrackList TrackList.Msg
    | Search Search.Msg
    | Player Player.Msg
    | Routing Routing.Msg
