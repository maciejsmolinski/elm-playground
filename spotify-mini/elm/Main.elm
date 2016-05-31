module Main exposing (main)

import Html.App
import App.Model exposing (App)
import App.View
import App.Action exposing (Action(UpdateTrackList))
import Ports.Ports exposing (updateTrackList)


main : Program Never
main =
    Html.App.program
        { init = App.Model.initial
        , view = App.View.render
        , update = App.Model.update
        , subscriptions = subscriptions
        }


subscriptions : App -> Sub Action
subscriptions trackList =
    updateTrackList UpdateTrackList
