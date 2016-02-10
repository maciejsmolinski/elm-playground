module Todo where

import Modules.TodoList exposing (render)
import Modules.TodoItems exposing (TodoItems)
import Modules.TodoMailbox exposing (TodoActions(Add, Remove, Clear), signal)

initialItems: TodoItems
initialItems =
  [ "Read articles about Elm Signals"
  , "Rest a little bit"
  ]

update: TodoActions -> TodoItems -> TodoItems
update action list =
  case action of
    Add todoName ->
      if List.member todoName list then
        list
      else
        list ++ [ todoName ]

    Clear ->
      [ ]

    Remove todoName ->
      List.filter (\item -> not (item == todoName)) list

model =
  Signal.foldp update initialItems signal

main =
  Signal.map Modules.TodoList.render model
