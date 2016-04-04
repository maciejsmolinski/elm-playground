module TrackList.View (render) where

import TrackList.Model exposing (TrackList)
import Html exposing (Html, div, text)

render : TrackList -> Html
render trackList =
  let
    trackToElement =
      (\track -> div [] [ text track.title ])

    tracksElements =
      List.map trackToElement trackList
  in
    div [] tracksElements
