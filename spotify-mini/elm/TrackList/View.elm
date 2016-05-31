module TrackList.View exposing (render)

import TrackList.Model exposing (TrackList)
import Html exposing (Html, div, text)
import App.Action exposing (Action)


render : TrackList -> Html Action
render trackList =
  let
    trackToElement =
      (\track -> div [] [ text track.title ])

    tracksElements =
      List.map trackToElement trackList
  in
    div [] tracksElements
