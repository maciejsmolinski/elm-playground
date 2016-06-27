module Routing.App exposing (..)

import App.Model exposing (App)
import App.Msg as App exposing (Msg)
import Navigation


{-
   Custom URL Parser

   Transforms location to something Application's init and urlUpdate functions understand, e.g. "/app", 0 or even AppHome
   Sample Scenario:

     Given location "localhost/index#/app"
     When parsed by a customly defined parser
     Then can be turned into "/app"
-}


urlParser : Navigation.Parser String
urlParser =
    Navigation.makeParser (\location -> location.hash)


mapUrl : String -> App -> ( App, Cmd App.Msg )
mapUrl uri model =
    case uri of
        "#/" ->
            ( model, Cmd.none )

        _ ->
            ( model, Navigation.modifyUrl ("#/") )
