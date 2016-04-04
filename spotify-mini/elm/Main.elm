module Main where

import Html exposing (Html)
import App.Model exposing (App)
import App.View

state : Signal App
state =
  App.Model.signal

main : Signal Html
main =
  Signal.map App.View.render state
