port module Ports.Ports exposing (..)

import TrackList.Model exposing (TrackList)


port updateTrackList : (TrackList -> msg) -> Sub msg

port search : String -> Cmd msg
