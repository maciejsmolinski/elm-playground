module App.View exposing (render)

import App.Model exposing (App)
import Html exposing (Html, div)
import Html.App
import Search.View
import TrackList.View
import Player.View
import App.Msg exposing (Msg(..))


render : App -> Html Msg
render app =
    div []
        [ Html.App.map Search (Search.View.render app.search)
        , Player.View.render app.currentTrack
        , Html.App.map TrackList (TrackList.View.render app.trackList)
        ]
