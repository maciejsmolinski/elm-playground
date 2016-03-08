module User (User, render, initial, getData) where

{-| User Module

# Definition
@docs User

# Common Helpers
@docs render, initial, getData

-}


import Http
import Task exposing (Task)
import Html exposing (Html, div, img, text)
import Html.Attributes exposing (src)
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
  User "" "" ""


{-| Json Decoder extracting required data
-}
extractData: Json.Decoder (List (String, String, String))
extractData =
  let
    data =
      Json.at ["user"]
        <| Json.object3 (,,)
            ("email" := Json.string)
            (Json.at ["picture", "medium"] Json.string)
            ("username" := Json.string)
  in
      ("results" := Json.list data)


{-| Fire HTTP Request
-}
getData: Task Http.Error (List (String, String, String))
getData =
  Http.get extractData "https://randomuser.me/api/"


{-| Render User given actual model
-}
render: User -> Html
render user =
  div
    []
    [ div [] [ img [ src user.picture ] [] ]
    , div [] [ text user.username ]
    , div [] [ text user.email ]
    ]
