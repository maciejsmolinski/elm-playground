module App.View exposing (render)

import App.Model exposing (App)
import Html exposing (Html, div)
import Search.View
import TrackList.View
import App.Action exposing (Action)


render : App -> Html Action
render app =
    div []
        [ Search.View.render app.search
        , TrackList.View.render app.trackList
        ]
