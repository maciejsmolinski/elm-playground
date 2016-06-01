module Track.Model exposing (Track, initial, empty)


type alias Track =
    { title : String
    , cover : String
    , src : String
    }


empty : Track
empty =
    Track "" "" ""


initial : Track
initial =
    empty
