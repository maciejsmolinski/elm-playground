module User exposing (User, Msg(..), init, update, view)

import Http
import Task exposing (Task)
import Html exposing (Html, div, img, text, span, i)
import Html.Attributes exposing (src, class)
import Json.Decode as Json exposing ((:=))
import Date


type alias User =
  { email: String
  , picture: String
  , username: String
  , city: String
  , joined: Int
  }


type Msg = NoOp
           | Load
           | UpdateFields User


empty : User
empty =
  User "..." "https://placehold.it/300x300?text=loading+picture" "..." "..." 0


init : (User, Cmd Msg)
init =
  (empty, getUser)


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

    joinedYear =
      case user.joined of
        0 ->
          "..."

        date ->
          toString
            <| Date.year
            <| Date.fromTime (date * 1000)

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
              [ text ("Joined in " ++ joinedYear) ]
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


getUser : Cmd Msg
getUser =
  Task.perform (always NoOp) UpdateFields (Http.get extractData "https://randomuser.me/api/")


extractData : Json.Decoder User
extractData =
  let
    user =
      Json.object5 User
        ("email" := Json.string)
        (Json.at ["picture", "large"] Json.string)
        (Json.at ["login", "username"] Json.string)
        (Json.at ["location", "city"] Json.string)
        ("registered" := Json.int)
  in
      Json.object1
        (Maybe.withDefault empty << List.head)
        ("results" := Json.list user)
