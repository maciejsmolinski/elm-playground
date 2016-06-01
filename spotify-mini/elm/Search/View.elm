module Search.View exposing (render)

import Search.Model exposing (Search)
import Html exposing (Html, input)
import Html.Attributes exposing (type')
import Html.Events exposing (onInput)
import App.Action exposing (Action(UpdateSearch))


render : Search -> Html Action
render _ =
    input
        [ type' "search"
        , onInput UpdateSearch
        ]
        []
