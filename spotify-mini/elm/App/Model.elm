module App.Model (App, signal) where

import TrackList.Model exposing (TrackList)
import Search.Model exposing (Search)
import App.Mailbox
import App.Action exposing (Action(NoOp))


type alias App =
  { trackList : TrackList
  , search : Search
  }


initial : App
initial =
  App TrackList.Model.initial Search.Model.initial


update : Action -> App -> App
update action app =
  case action of
    NoOp ->
      app


signal : Signal App
signal =
  Signal.foldp
    update
    initial
    App.Mailbox.signal
