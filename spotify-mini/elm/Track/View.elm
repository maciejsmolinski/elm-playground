module Track.View exposing (render)

import Track.Model exposing (Track)
import Html exposing (Html, div, audio, img, text, p)
import Html.Attributes exposing (src, controls, class)
import App.Action exposing (Action)


render : Track -> Html Action
render track =
    div [ class "container helpers with-small-top-gap" ]
        [ div [ class "row" ]
            [ div [ class "two columns" ]
                [ img
                    [ src track.cover
                    , class "helpers is-responsive"
                    ]
                    []
                ]
            , div [ class "ten columns" ]
                [ p [] [ text track.title ]
                , audio
                    [ src track.src
                    , controls True
                    ]
                    []
                ]
            ]
        ]
