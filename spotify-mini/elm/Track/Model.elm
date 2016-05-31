module Track.Model exposing (Track, initial)


type alias Track =
  { title : String
  , cover : String
  , src : String
  }


initial : Track
initial =
  Track "" "" ""
