module Modules.TodoItem (TodoItem, render) where

import Html exposing (div, text, br, button)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)

import Modules.TodoMailbox exposing (TodoActions(Remove), address)

type alias TodoItem = String

render: TodoItem -> Html.Html
render todoItem =
  div [ style
        [ ("border", "1px solid #eee")
        , ("margin", "1em")
        , ("padding", "1em")
        ]
      ] [ text todoItem
        , br [] []
        , br [] []
        , button [ onClick address (Remove todoItem) ] [ text "Remove" ]
        ]
