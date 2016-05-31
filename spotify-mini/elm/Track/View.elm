module Track.View exposing (render)

import Track.Model exposing (Track)
import Html exposing (Html, div, h4, audio, img, text)
import Html.Attributes exposing (src, style, width, height, controls)
import App.Action exposing (Action)


render : Track -> Html Action
render track =
    div [ style [ ( "margin-top", "3em" ) ] ]
        [ h4 []
            [ text track.title ]
        , img
            [ src track.cover
            , width 200
            , height 200
            , style [ ( "display", "block" ), ( "margin", "1em auto" ) ]
            ]
            []
        , audio
            [ src track.src
            , controls True
            ]
            []
        ]
