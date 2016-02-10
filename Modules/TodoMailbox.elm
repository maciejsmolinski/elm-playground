module Modules.TodoMailbox (TodoActions(Add, Remove, Clear), address, signal) where

import Signal

type TodoActions = Add String | Remove String | Clear

mailbox: Signal.Mailbox TodoActions
mailbox = Signal.mailbox Clear


address =
  mailbox.address

signal =
  mailbox.signal
