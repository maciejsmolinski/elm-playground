module Routing.App exposing (..)

import App.Model exposing (App)
import App.Msg as App exposing (Msg)
import Navigation


urlParser : Navigation.Parser String
urlParser =
    Navigation.makeParser (\location -> "/")


mapUrl : String -> App -> ( App, Cmd App.Msg )
mapUrl uri model =
    ( model, Cmd.none )
