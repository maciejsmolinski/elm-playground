module Search.Model exposing (Search, initial)


type alias Search =
    { value : String
    }


initial : Search
initial =
    Search ""
