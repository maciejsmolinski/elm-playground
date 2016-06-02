module Track.View exposing (render)

import Track.Model exposing (Track)
import Html exposing (Html, div, audio, img, text, p)
import Html.Attributes exposing (src, controls, class)
import Html.Events exposing (onDoubleClick)
import App.Action exposing (Action(..))


render : Track -> Html Action
render track =
    div [ class "track", onDoubleClick (PlayTrack track) ]
        [ div [ class "track-cover" ]
            [ img
                [ src track.cover
                , class "helpers is-responsive"
                ]
                []
            ]
        , div [ class "track-title" ]
            [ p [] [ text track.title ] ]
        ]
