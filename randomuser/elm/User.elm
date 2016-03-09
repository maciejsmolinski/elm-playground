module User (User, render, initial, getData) where

{-| User Module

# Definition
@docs User

# Common Helpers
@docs render, initial, getData

-}


import Http
import Task exposing (Task)
import Html exposing (Html, div, img, text, span, i)
import Html.Attributes exposing (src, class)
import Json.Decode as Json exposing ((:=))


{-| User Structure

  user =
    User "email@domain.com", "http://placehold.it/200x200"

-}
type alias User =
  { email: String
  , picture: String
  , username: String
  }


{-| Returns initial empty User model
-}
initial: User
initial =
  User
    "..."
    "//placehold.it/300x300?text=loading+picture"
    "..."


{-| Json Decoder extracting required data
-}
extractData: Json.Decoder User
extractData =
  let
    user =
      Json.at ["user"]
        <| Json.object3 User
            ("email" := Json.string)
            (Json.at ["picture", "large"] Json.string)
            ("username" := Json.string)
  in
      Json.object1
        (Maybe.withDefault initial << List.head)
        ("results" := Json.list user)


{-| Fire HTTP Request
-}
getData: Task Http.Error User
getData =
  Http.get extractData "https://randomuser.me/api/"


{-| Render User given actual model
-}
render: User -> Html
render user =
  let

    image =
      div
        [ class "image" ]
        [ img [ src user.picture ] [] ]

    content =
      div
        [ class "content" ]
        [ div
            [ class "header" ]
            [ text user.username ]
        , div
            [ class "meta" ]
            [ span
              [ class "date" ]
              [ text "Joined in 2016" ]
            , div
              [ class "description" ]
              [ text "Living in New York" ]
            ]
        ]

    extra =
      if user.email /= "" then
        div
          [ class "extra content" ]
          [ div
            []
            [ i
              [ class "mail outline icon" ]
              []
            , text user.email
            ]
          ]
      else
        div [] []
  in
    div
      [ class "ui card helpers centered-horizontally with-double-top-gap" ]
      [ image, content, extra ]
