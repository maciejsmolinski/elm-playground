module Main where

{-| Random User Application
-}

import Http
import Task exposing (Task)
import Html exposing (button, div, text, Html)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import Signal
import User exposing (User)

{-| Application Actions
-}
type Action = NoOp
            | Load
            | UpdateFields User

{-| Application Mailbox handling signals
-}
mailbox: Signal.Mailbox Action
mailbox = Signal.mailbox NoOp

{-| Function responsible for updating User model based on actions
-}
modelUpdate: Action -> User -> User
modelUpdate action model =
  case Debug.log "Action" action of
    UpdateFields user ->
      user

    Load ->
      User.initial

    NoOp ->
      model

{-| Signal emitting User model every time update is made
-}
modelSignal: Signal User
modelSignal =
  Signal.foldp modelUpdate User.initial mailbox.signal

{-| Application Render Function
-}
render: User -> Html
render user =
  let
    nav =
      div
        [ class "helpers with-top-gap centered-text" ]
        [
          button
            [ onClick mailbox.address Load]
            [ text "Load" ]
        ]
  in
    div [] [ User.render user, nav ]

{-| Application Entry Point (renders every time signal is received)
-}
main: Signal Html
main =
  Signal.map render modelSignal


{-| Port that fires HTTP request every time Load signal is emitted
-}
port refresh: Signal (Task Http.Error ())
port refresh =
  let
    signal = Signal.filter
              (\action -> action == Load)
              NoOp
              mailbox.signal
    handle = Signal.send mailbox.address << UpdateFields
    task   = always (Task.andThen User.getData handle)
  in
    Signal.map task signal
