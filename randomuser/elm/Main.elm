module Main where

import Http
import Json.Decode as Json exposing ((:=))
import Task exposing (Task)
import Html exposing (text, Html)
import Signal
import Time
import String

type alias User =
  { emails: List String
  }

type Action = NoOp
            | UpdateEmails (List String)

mailbox: Signal.Mailbox Action
mailbox = Signal.mailbox NoOp

modelUpdate: Action -> User -> User
modelUpdate action model =
  case Debug.log "Action" action of
    UpdateEmails emails ->
      { model | emails = emails }
    _ ->
      model

modelSignal: Signal User
modelSignal =
  Signal.foldp modelUpdate (User [""]) mailbox.signal

view: User -> Html
view model =
  text
    <| String.join ", " (model.emails)

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
handleData email =
    Signal.send mailbox.address (UpdateEmails email)

port runner2: Signal (Task Http.Error ())
port runner2 =
  Signal.map (always (Task.andThen getData handleData)) (Time.every (5 * Time.second))
