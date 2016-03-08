module User (User, render, initial, getData) where

{-| User Module

# Definition
@docs User

# Common Helpers
@docs render, initial, getData

-}


import Http
import Task exposing (Task)
import Html exposing (Html, div, text)
import Json.Decode as Json exposing ((:=))


{-| User Structure

  user =
    User "email@domain.com", "http://placehold.it/200x200"

-}
type alias User =
  { email: String
  }


{-| Returns initial empty User model
-}
initial: User
initial =
  User ""


{-| Json Decoder extracting required data
-}
getEmails: Json.Decoder (List String)
getEmails =
  let
    email = Json.at ["user", "email"] Json.string
  in
    ("results" := Json.list email)


{-| Fire HTTP Request
-}
getData: Task Http.Error (List String)
getData =
  Http.get getEmails "https://randomuser.me/api/"


{-| Render User given actual model
-}
render: User -> Html
render user =
  div
    []
    [ text user.email
    ]
