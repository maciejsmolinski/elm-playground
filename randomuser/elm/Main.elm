module Main where

import Http
import Json.Decode as Json exposing ((:=))
import Task exposing (Task)
import Html exposing (text, Html)
import Signal
import Time

type alias User =
  { email: String
  }

type Action = NoOp
            | UpdateEmail String

mailbox: Signal.Mailbox Action
mailbox = Signal.mailbox NoOp

modelUpdate: Action -> User -> User
modelUpdate action model =
  case Debug.log "Action" action of
    UpdateEmail email ->
      { model | email = email }
    _ ->
      model

modelSignal: Signal User
modelSignal =
  Signal.foldp modelUpdate (User "") mailbox.signal

view: User -> Html
view model =
  text model.email

main: Signal Html
main =
  Signal.map view modelSignal

getData: Task Http.Error (List String)
getData =
  Http.get getEmails "https://randomuser.me/api/"

getEmails: Json.Decoder (List String)
getEmails =
  let
    email = Json.at ["user", "email"] Json.string
  in
    ("results" := Json.list email)

handleData: List String -> Task a ()
handleData emails =
    let
      email = Maybe.withDefault "no email" (List.head emails)
    in
      Signal.send mailbox.address (UpdateEmail email)


port refresh: Signal (Task Http.Error ())
port refresh =
  let
    signal = Time.every (5 * Time.second)
    task   = always (Task.andThen getData handleData)
  in
    Signal.map task signal
