module Search.Update exposing (update)

import Search.Msg exposing (Msg(..))
import Search.Model exposing (Search)
import Ports.Ports exposing (search)


update : Msg -> Search -> ( Search, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        UpdateSearch query ->
            ( { model | value = query }, search query )
