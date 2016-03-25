module Main where

import Html exposing (Html, div, text)

import TrackList.Model exposing (TrackList)
import Track.Model exposing (Track)

main : Html
main =
  let
    trackList = [ Track "Track 1" "" ""
                , Track "Track 2" "" ""
                , Track "Track 3" "" ""
                , Track "Track 4" "" ""
                ]
  in
    playlist trackList

playlist : TrackList -> Html
playlist trackList =
  let
    trackToElement =
      (\track -> div [] [ text track.title ])

    tracksElements =
      List.map trackToElement trackList
  in
    div [] tracksElements
