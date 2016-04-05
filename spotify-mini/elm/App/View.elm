module App.View (render) where

import App.Model exposing (App)
import Html exposing (Html, div)
import Search.View
import TrackList.View


render : App -> Html
render app =
  div
    []
    [ Search.View.render app.search
    , TrackList.View.render app.trackList
    ]
