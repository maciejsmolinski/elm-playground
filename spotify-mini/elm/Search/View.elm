module Search.View exposing (render)

import Search.Model exposing (Search)
import Html exposing (Html, input)
import Html.Attributes exposing (type')
import App.Action exposing (Action)


render : Search -> Html Action
render _ =
  input [ type' "search" ] []
