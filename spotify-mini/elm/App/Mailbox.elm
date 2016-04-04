module App.Mailbox (signal, address) where

import App.Action exposing (Action(NoOp))

mailbox : Signal.Mailbox Action
mailbox = Signal.mailbox NoOp

signal : Signal.Signal Action
signal =
  mailbox.signal

address : Signal.Address Action
address =
  mailbox.address
