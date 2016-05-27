module Main exposing (main)

import Html exposing (Html, text, button, div, input, br, span)
import Html.Attributes exposing (class, type', value)
import Html.Events exposing (onClick, on, onInput, targetValue)
import Html.App
import String
import Json.Decode as Json



main : Program Never
main =
  Html.App.program
    { init = init
    , view = view
    , update = update
    , subscriptions = \_ -> Sub.none
    }


type alias Model =
  { field: String
  , list: List (Int, String)
  , id: Int
  }


type Msg
  = UpdateField String
  | Remove Int
  | Add
  | Clear
  | NoOp


init : (Model, Cmd Msg)
init =
  (empty, Cmd.none)


empty : Model
empty =
  (Model "" [] 0)


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case Debug.log "Message" msg of
    UpdateField name ->
      ({ model | field = name }, Cmd.none)
    Add ->
      let
        members = List.map (snd) model.list
      in
        if String.isEmpty model.field then
          (model, Cmd.none)
        else if List.member model.field members then
          (model, Cmd.none)
        else
          ({ model
          | id    = model.id + 1
          , list  = (model.list ++ [ (model.id + 1, model.field) ])
          , field = ""
          }, Cmd.none)
    Remove id ->
      let
        newList = List.filter (\(itemId, _) -> itemId /= id) model.list
      in
        ({ model | list = newList }, Cmd.none)
    Clear ->
      ({ model
      | list = []
      , id = 0
      }, Cmd.none)
    _ ->
      (model, Cmd.none)


view : Model -> Html Msg
view model =
  let
    add  = [ br [] [], addTodo model ]
    list = List.map item model.list
    clr  = [ br [] [], clear ]
  in
    div [] (add ++ list ++ clr)


{- Html Helpers -}
addTodo : Model -> Html Msg
addTodo model =
  div
    [ class "row" ]
    [ div
      [ class "ten columns" ]
      [ inpt model.field ]
    , div
      [ class "two columns" ]
      [ btn "Add" Add ]
    ]


item : (Int, String) -> Html Msg
item (id, name) =
  div
  [ class "row" ]
  [ div
    [ class "ten columns" ]
    [ text name ]
  , div
    [ class "two columns helpers is-right-aligned" ]
    [ txt "╳" (Remove id) ]
  ]


clear : Html Msg
clear =
  div
    [ class "row" ]
    [ btn "Clear" Clear ]


btn : String -> Msg -> Html Msg
btn label action =
  button
  [ onClick action ]
  [ text label ]


txt : String -> Msg -> Html Msg
txt label action =
  span
  [ onClick action, class "helpers is-actionable is-mini" ]
  [ text label ]


inpt : String -> Html Msg
inpt label =
  let
    onKeyUp =
      Json.map
        (\keyCode -> if keyCode == 13 then Add else NoOp)
        (Json.at ["keyCode"] Json.int)
  in
    input
    [ onInput UpdateField
    , on "keyup" onKeyUp
    , class "u-full-width"
    , type' "text"
    , value label
    ]
    []
