module App.View exposing (render)

import App.Model exposing (App)
import Html exposing (Html, div)
import Search.View
import TrackList.View
import Player.View
import App.Msg exposing (Msg)


render : App -> Html Msg
render app =
    div []
        [ Search.View.render app.search
        , Player.View.render app.currentTrack
        , TrackList.View.render app.trackList
        ]
