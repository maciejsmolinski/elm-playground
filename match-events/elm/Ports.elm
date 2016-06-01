port module Ports exposing (..)


type alias Event =
    { code : String
    , label : String
    }


port addEvent : (Event -> msg) -> Sub msg
