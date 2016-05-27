module User exposing (User, Msg(..), init, update, view)

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
    User "email@domain.com", "https://placehold.it/200x200"

-}
type alias User =
  { email: String
  , picture: String
  , username: String
  , city: String
  }

{-| User Messages
-}
type Msg = NoOp
          | Load
          | UpdateFields User

{-| Returns initial Model
-}
init : (User, Cmd Msg)
init =
  (empty, getUser)

{-| Returns empty User
-}
empty : User
empty =
  User "..." "https://placehold.it/300x300?text=loading+picture" "..." "..."

{-| Function responsible for updating User model based on actions
-}
update : Msg -> User -> (User, Cmd Msg)
update action model =
  case Debug.log "Action" action of
    UpdateFields user ->
      (user, Cmd.none)

    Load ->
      init

    NoOp ->
      (model, Cmd.none)

view : User -> Html Msg
view user =
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
              [ class "description helpers capitalized" ]
              [ text ("Living in " ++ user.city) ]
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



{-| Json Decoder extracting required data
-}
extractData: Json.Decoder User
extractData =
  let
    user =
      Json.object4 User
        ("email" := Json.string)
        (Json.at ["picture", "large"] Json.string)
        (Json.at ["login", "username"] Json.string)
        (Json.at ["location", "city"] Json.string)
  in
      Json.object1
        (Maybe.withDefault empty << List.head)
        ("results" := Json.list user)


{-| Fire HTTP Request
-}
getUser: Cmd Msg
getUser =
  Task.perform (always NoOp) UpdateFields (Http.get extractData "https://randomuser.me/api/")
