module Main where

{-| Random User Application

@docs Action, handleData, mailbox, modelSignal, modelUpdate, view, main

-}

import Http
import Task exposing (Task)
import Html exposing (div, Html)
import Signal
import Time
import User exposing (User)

{-| Application Actions
-}
type Action = NoOp
            | UpdateData (String, String, String)

{-| Application Mailbox handling signals
-}
mailbox: Signal.Mailbox Action
mailbox = Signal.mailbox NoOp

{-| Function responsible for updating User model based on actions
-}
modelUpdate: Action -> User -> User
modelUpdate action model =
  case Debug.log "Action" action of
    UpdateData (email, picture, username) ->
      { model
      | email = email
      , picture = picture
      , username = username
      }

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
  div [] [ User.render user ]

{-| Application Entry Point (renders every time signal is received)
-}
main: Signal Html
main =
  Signal.map render modelSignal


{-| Handle Incoming User Data from Ports via emitting signals
-}
handleData: List (String, String, String) -> Task a ()
handleData data =
    let
      extracted = Maybe.withDefault ("", "", "") (List.head data)
    in
      Signal.send mailbox.address (UpdateData extracted)

{-| Port that fires HTTP request every 30 seconds
-}
port refresh: Signal (Task Http.Error ())
port refresh =
  let
    signal = Time.every (30 * Time.second)
    task   = always (Task.andThen User.getData handleData)
  in
    Signal.map task signal
