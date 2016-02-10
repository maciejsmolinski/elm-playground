module Modules.TodoItems (TodoItems, render) where

import Modules.TodoItem exposing (TodoItem)

import Html exposing (div)
import Html.Attributes exposing (style)

type alias TodoItems = List TodoItem

render: TodoItems -> Html.Html
render todoItems =
  div [ style
        [ ("border", "1px solid #eee")
        , ("margin", "1em")
        , ("padding", "1em")
        ]
      ] (List.map Modules.TodoItem.render todoItems)
