module Search.View (render) where

import Search.Model exposing (Search)
import Html exposing (Html, input)
import Html.Attributes exposing (type')


render : Search -> Html
render _ =
  input [ type' "search" ] []
