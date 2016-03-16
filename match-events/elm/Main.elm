module Main where

import Html exposing (text, div)
import Signal
import Html exposing (Html)

type alias Event =
  String

type alias Events =
  List Event

type alias Model =
  { events: Events
  }

type Action
  = NoOp
  | AddEvent String

mailbox: Signal.Mailbox Action
mailbox = Signal.mailbox NoOp

initialModel : Model
initialModel =
  Model []

signalModel : Signal Model
signalModel =
  let
    portSignal =
      Signal.map AddEvent events

    mailboxSignal =
      mailbox.signal

    signals =
      Signal.merge portSignal mailboxSignal
  in
    Signal.foldp updateModel initialModel signals

updateModel : Action -> Model -> Model
updateModel action model =
  case action of
    AddEvent eventName ->
      { model | events = model.events ++ [ eventName ] }

    NoOp ->
      model

main : Signal Html
main =
  Signal.map view signalModel

view : Model -> Html
view model =
  let
    events =
      List.map (\name -> div [] [ text name ]) model.events
  in
    div
      []
      events

port events : Signal Event
