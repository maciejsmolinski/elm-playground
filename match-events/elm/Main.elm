module Main exposing (main)

import Html exposing (text, div, p)
import Html exposing (Html)
import Html.Attributes exposing (class)
import Html.App
import Maybe
import String
import Ports exposing (addEvent)

type alias Event =
  { code: String
  , label: String
  }


type alias Events =
  List Event


type alias Model =
  { events: Events
  }


type Msg
  = NoOp
  | AddEvent Event


main : Program Never
main =
  Html.App.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }


emptyModel : Model
emptyModel =
  Model []


emptyEvent : Event
emptyEvent =
  Event "" ""


init : (Model, Cmd Msg)
init =
  (emptyModel, Cmd.none)


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case Debug.log "Message" msg of
    AddEvent eventName ->
      ({ model | events = model.events ++ [ eventName ] }, Cmd.none)

    NoOp ->
      (model, Cmd.none)


view : Model -> Html Msg
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


pitch : Event -> Html Msg
pitch lastEvent =
  let
    pitchClass =
      class "pitch helpers is-horizontally-centered is-centered"

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


subscriptions : Model -> Sub Msg
subscriptions model =
  addEvent AddEvent
