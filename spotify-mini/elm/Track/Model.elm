module Track.Model exposing (Track, initial, empty)


type alias Track =
    { title : String
    , cover : String
    , src : String
    , duration : String
    }


empty : Track
empty =
    Track "" "" "" ""


initial : Track
initial =
    empty
