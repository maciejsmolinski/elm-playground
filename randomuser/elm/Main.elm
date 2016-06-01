module Main exposing (main)

{-| Random User Application
-}

import Html exposing (button, div, text, Html)
import Html.Attributes exposing (class)
import Html.App
import Html.Events exposing (onClick)
import User exposing (User, Msg)


main : Program Never
main =
    Html.App.program
        { init = User.init
        , view = view
        , update = User.update
        , subscriptions = \_ -> Sub.none
        }


view : User -> Html User.Msg
view model =
    let
        nav =
            div [ class "helpers with-top-gap small centered-text" ]
                [ button [ onClick User.Load ]
                    [ text "Load" ]
                ]
    in
        div []
            [ User.view model
            , nav
            ]
