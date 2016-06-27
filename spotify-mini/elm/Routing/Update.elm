module Routing.Update exposing (update)

import Routing.Msg exposing (Msg(..))
import Routing.Model exposing (Routing)
import Navigation


update : Msg -> Routing -> ( Routing, Cmd Msg )
update msg model =
    case msg of
        Home ->
            ( { model | page = Just "home" }, Cmd.none )

        NotFound ->
            ( { model | page = Just "not-found" }, Cmd.none )

        Redirect uri ->
            ( { model | page = Nothing }, Navigation.modifyUrl uri )
