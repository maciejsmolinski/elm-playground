module Main where

import Http
import Json.Decode as Json exposing ((:=))
import Task exposing (Task)
import Graphics.Element exposing (show, Element)
import Signal

type alias User =
  { email: String
  }

type Action = NoOp
            | UpdateEmail String

mailbox: Signal.Mailbox Action
mailbox = Signal.mailbox NoOp

modelUpdate: Action -> User -> User
modelUpdate action model =
  case action of
    UpdateEmail email ->
      { model | email = email }
    _ ->
      model

modelSignal: Signal User
modelSignal =
  Signal.foldp modelUpdate (User "") mailbox.signal

view: User -> Element
view model =
  show model.email

main: Signal Element
main =
  Signal.map view modelSignal
--
--
-- getData: Task Http.Error String
-- getData =
--   Http.get getEmail "https://randomuser.me/api/"
--
-- getEmail: Json.Decoder String -> String
-- getEmail =
--   Json.at ["results", "user", "email"]
--
-- handleData: String -> Signal.Address Action
-- handleData email =
--   Signal.forwardTo mailbox.address (\email -> UpdateEmail email)
--
-- port run: Task Http.Error ()
-- port run =
--   Task.andThen getData handleData
