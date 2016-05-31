module TrackList.Model exposing (TrackList, initial)

import Track.Model exposing (Track)


type alias TrackList =
    List Track


initial : TrackList
initial =
    []
