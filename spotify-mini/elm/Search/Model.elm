module Search.Model exposing (Search, initial, empty)


type alias Search =
    { value : String
    }


empty : Search
empty =
    Search ""


initial : Search
initial =
    empty
