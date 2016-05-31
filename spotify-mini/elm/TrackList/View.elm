module TrackList.View exposing (render)

import TrackList.Model exposing (TrackList)
import Track.View
import Html exposing (Html, div, text)
import App.Action exposing (Action)


render : TrackList -> Html Action
render trackList =
    let
        tracksElements =
            List.map Track.View.render trackList
    in
        div [] tracksElements
