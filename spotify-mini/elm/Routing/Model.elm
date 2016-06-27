module Routing.Model exposing (Routing, initial, empty)


type alias Routing =
    { page : Maybe String
    }


empty : Routing
empty =
    Routing Nothing


initial : Routing
initial =
    empty
