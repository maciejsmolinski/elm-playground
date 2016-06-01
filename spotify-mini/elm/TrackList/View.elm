module TrackList.View exposing (render)

import TrackList.Model exposing (TrackList)
import Track.View
import Html exposing (Html, div, text)
import App.Action exposing (Action)


render : TrackList -> Html Action
render trackList =
    let
        tracksElements =
            if List.length trackList > 0 then
                List.map Track.View.render trackList
            else
                [ div [] [ text "Empty search results" ] ]
    in
        div []
            tracksElements
