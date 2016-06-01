module TrackList.Model exposing (TrackList, initial, empty)

import Track.Model exposing (Track)


type alias TrackList =
    List Track


empty : TrackList
empty =
    []


initial : TrackList
initial =
    empty
