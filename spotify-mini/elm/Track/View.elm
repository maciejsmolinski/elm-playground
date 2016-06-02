module Track.View exposing (render)

import Track.Model exposing (Track)
import Html exposing (Html, div, audio, img, text, p)
import Html.Attributes exposing (src, controls, class)
import Html.Events exposing (onDoubleClick)
import App.Action exposing (Action(..))


render : Track -> Html Action
render track =
    div [ class "container helpers with-small-top-gap" ]
        [ div [ class "row", onDoubleClick (PlayTrack track) ]
            [ div [ class "one column" ]
                [ img
                    [ src track.cover
                    , class "helpers is-responsive"
                    ]
                    []
                ]
            , div [ class "two columns" ]
                [ p [] [ text track.title ] ]
            ]
        ]
