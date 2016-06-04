module Search.View exposing (render)

import Search.Model exposing (Search)
import Html exposing (Html, input)
import Html.Attributes exposing (type')
import Html.Events exposing (onInput)
import Search.Msg as Search exposing (Msg(UpdateSearch))


render : Search -> Html Search.Msg
render _ =
    input
        [ type' "search"
        , onInput UpdateSearch
        ]
        []
