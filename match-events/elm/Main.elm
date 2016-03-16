module Main where

import Html exposing (text, div, p)
import Signal
import Html exposing (Html)
import Html.Attributes exposing (class)
import Maybe
import String

type alias Event =
  { code: String
  , label: String
  }

type alias Events =
  List Event

type alias Model =
  { events: Events
  }

type Action
  = NoOp
  | AddEvent Event

mailbox: Signal.Mailbox Action
mailbox = Signal.mailbox NoOp

emptyModel : Model
emptyModel =
  Model []

emptyEvent : Event
emptyEvent =
  Event "" ""


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
    Signal.foldp updateModel emptyModel signals


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
      List.map
        (\{code, label} -> div [] [ text label ])
        model.events

    lastEvent =
      model.events
        |> List.head << List.reverse
        |> Maybe.withDefault emptyEvent
  in
    div [] [ pitch lastEvent ]


pitch: Event -> Html
pitch lastEvent =
  let
    pitchClass =
      class "pitch is-horizontally-centered is-centered"

    emptyClass =
      class "pitch-empty"

    eventClass =
      class "pitch-event pulse animated"

    pitchContents =
      if String.isEmpty lastEvent.label then
        p [ emptyClass ] [ text "Match hasn't started yet..." ]
      else
        p [ eventClass ] [ text lastEvent.label ]
  in
    div [ pitchClass ] [ pitchContents ]


port events : Signal (Event)
