module Main where

import Html exposing (div, text, input, button)
import Html.Attributes exposing (value)
import Html.Events exposing (on, onClick, targetValue)
import String

{- Action Types Enum -}
type Actions
  = UpdateField String
  | Add
  | NoOp

{- State Structure -}
type alias State =
  { field: String
  , list: List String
  }

{- Message bus -}
dispatcher: Signal.Mailbox Actions
dispatcher =
  Signal.mailbox NoOp

{- Changes state based on action -}
stateChangeFunction: Actions -> State -> State
stateChangeFunction action state =
  case action of
    UpdateField text ->
      { state | field = text }

    Add ->
      if List.member state.field state.list then
        state
      else if String.length state.field == 0 then
        state
      else
        { state | list = state.list ++ [ state.field ] }

    _ -> state

{- Initial state to be used in stateChange -}
initialState: State
initialState =
  { field = ""
  , list = [ "Some", "Fields" ]
  }

{- Observable State (listens to dispatcher) -}
stateChange =
  Signal.foldp stateChangeFunction initialState dispatcher.signal


{- View receiving publish action and current state -}
view: Signal.Address Actions -> State -> Html.Html
view address state =
  div
    []
    ([ input
        [ value state.field
        , on "input" targetValue (\str -> Signal.message address (UpdateField (toString str)))
        ]
        [ ]
    , button
        [ onClick address Add ]
        [ text "Add" ]
    ]
    ++ (List.map (\field -> div [] [ text field]) state.list))

{- Reacts to model changes rendering the view with given state -}
main =
  Signal.map (view dispatcher.address) stateChange
