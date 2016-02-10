module Modules.TodoList (render) where

import Html exposing (div, button, text)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)

import Modules.TodoItems exposing (TodoItems)
import Modules.TodoMailbox exposing (TodoActions(Add, Clear), address)


layout items =
  div [] [ Modules.TodoItems.render items ]

buttons =
  div [ style [ ("text-align", "center") ] ]
  [ (button [ onClick address (Add "Newly added todo item") ] [ text "Add Todo" ])
  , (button [ onClick address Clear ] [ text "Clear" ])
  ]

render: TodoItems -> Html.Html
render items =
  div [] [layout items, buttons]
