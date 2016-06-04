module Main exposing (main)

import Html.App
import App.Model exposing (App)
import App.View
import App.Update
import App.Msg as App exposing (Msg(..))
import TrackList.Msg exposing (Msg(..))
import Ports.Ports exposing (updateTrackList, clearTrackList)


main : Program Never
main =
    Html.App.program
        { init = App.Model.initial
        , view = App.View.render
        , update = App.Update.update
        , subscriptions = subscriptions
        }


subscriptions : App -> Sub App.Msg
subscriptions _ =
    Sub.batch
        [ updateTrackList (TrackList << UpdateTrackList)
        , clearTrackList (always (TrackList ClearTrackList))
        ]
