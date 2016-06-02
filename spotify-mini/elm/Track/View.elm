module Track.View exposing (render)

import Track.Model exposing (Track)
import Html exposing (Html, div, audio, img, text, p)
import Html.Attributes exposing (src, controls, class)
import Html.Events exposing (onClick)
import App.Msg exposing (Msg(..))


render : Track -> Html Msg
render track =
    div [ class "track", onClick (PlayTrack track) ]
        [ div [ class "track-cover" ]
            [ img
                [ src track.cover
                , class "helpers is-responsive"
                ]
                []
            ]
        , div [ class "track-title" ]
            [ text track.title ]
        , div [ class "track-duration" ]
            [ text track.duration ]
        ]
