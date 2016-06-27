module Main exposing (main)

import App.Model exposing (App)
import App.View
import App.Update
import App.Msg as App exposing (Msg(..))
import TrackList.Msg exposing (Msg(..))
import Ports.Ports exposing (updateTrackList, clearTrackList)
import Routing.App exposing (urlParser, mapUrl)
import Navigation


main : Program Never
main =
    Navigation.program urlParser
        { init = (\uri -> mapUrl uri (fst App.Model.initial))
        , urlUpdate = mapUrl
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
