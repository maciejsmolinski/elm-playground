module Main where

import Html exposing (text, div, p)
import Signal
import Html exposing (Html)
import Html.Attributes exposing (class)
import Maybe
import String

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

    lastEvent =
      model.events
        |> List.head << List.reverse
        |> Maybe.withDefault ""
  in
    div [] [ pitch lastEvent ]

pitch: String -> Html
pitch lastEvent =
  let
    contents =
      if String.isEmpty lastEvent then
        p [ class "pitch-empty" ] [ text "Match hasn't started yet..." ]
      else
        p [ class "pitch-event pulse" ] [ text lastEvent ]
  in
    div
      [ class "pitch is-horizontally-centered is-centered" ]
      [ contents ]

port events : Signal Event
