module Track.Model exposing (Track, initial, empty)


type alias Track =
    { title : String
    , cover : String
    , src : String
    , duration : String
    , current : Bool
    }


empty : Track
empty =
    Track "" "" "" "" False


initial : Track
initial =
    empty
