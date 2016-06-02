module Search.View exposing (render)

import Search.Model exposing (Search)
import Html exposing (Html, input)
import Html.Attributes exposing (type')
import Html.Events exposing (onInput)
import App.Msg exposing (Msg(UpdateSearch))


render : Search -> Html Msg
render _ =
    input
        [ type' "search"
        , onInput UpdateSearch
        ]
        []
