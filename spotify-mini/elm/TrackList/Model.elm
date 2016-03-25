module TrackList.Model (TrackList, initial) where

import Track.Model exposing (Track)

type alias TrackList =
  List Track

initial : TrackList
initial =
  []
