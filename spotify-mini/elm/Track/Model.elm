module Track.Model (Track, initial) where

type alias Track =
  { title: String
  , cover: String
  , src:   String
  }

initial : Track
initial =
  Track "" "" ""
