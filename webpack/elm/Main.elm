module Main where

import Html exposing (text, button, div, input, br)
import Html.Attributes exposing (class, type', value)
import Html.Events exposing (onClick, on, targetValue)
import Signal
import String
import Keyboard


{- Main -}
main: Signal Html.Html
main =
  Signal.map view model


{- State -}
type alias State =
  { field: String
  , list: List (Int, String)
  , id: Int
  }


{- Actions -}
type Actions
  = UpdateField String
  | Remove Int
  | Add
  | Clear
  | NoOp


{- Mailbox -}
mailbox: Signal.Mailbox Actions
mailbox = Signal.mailbox NoOp

{address, signal} = mailbox

signals: Signal Actions
signals =
  let
    enter = Keyboard.enter
          |> Signal.filter identity True
          |> Signal.map (always Add)
    actions = signal
  in
    Signal.merge enter actions




{- Model (state that reacts to signals) -}
updateState: Actions -> State -> State
updateState action state =
  let
    debug = Debug.log "Action" action
  in
    case action of
      UpdateField name ->
        { state | field = name }
      Add ->
        let
          members = List.map (snd) state.list
        in
          if String.isEmpty state.field then
            state
          else if List.member state.field members then
            state
          else
            { state
            | id    = state.id + 1
            , list  = (state.list ++ [ (state.id + 1, state.field) ])
            , field = ""
            }
      Clear ->
        { state
        | list = []
        , id = 0
        }
      _ ->
        state

model: Signal State
model =
  Signal.foldp updateState (State ("") ([]) (0)) signals


{- View -}
view: State -> Html.Html
view model =
  let
    add   = [ br [] [], addTodo model ]
    list  = List.map (\(id, name) -> div [] [text (toString id ++ ". " ++ name)]) model.list
    clr = [ br [] [], clear ]
  in
    div [] (add ++ list ++ clr)


{- Html Helpers -}
addTodo: State -> Html.Html
addTodo model =
  div
    [ class "row" ]
    [ div
      [ class "ten columns" ]
      [ inpt model.field ]
    , div
      [ class "two columns" ]
      [ btn "Add" Add ]
    ]

clear: Html.Html
clear =
  div
    [ class "row" ]
    [ btn "Clear" Clear ]


btn: String -> Actions -> Html.Html
btn label action =
  button
  [ onClick address action ]
  [ text label ]

inpt: String -> Html.Html
inpt label =
  input
  [ on
      "input"
      targetValue
      (Signal.message address << UpdateField)
  , class "u-full-width"
  , type' "text"
  , value label
  ]
  []
