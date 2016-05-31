module Main exposing (main)

import Html.App
import App.Model exposing (App)
import App.View

main : Program Never
main =
  Html.App.program
    { init = App.Model.initial
    , view = App.View.render
    , update = App.Model.update
    , subscriptions = \_ -> Sub.none
    }
