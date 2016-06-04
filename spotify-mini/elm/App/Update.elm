module App.Update exposing (update)

import App.Model exposing (App)
import App.Msg exposing (Msg(..))
import TrackList.Update
import Ports.Ports exposing (search, play)


update : Msg -> App -> ( App, Cmd Msg )
update action app =
    case Debug.log "Message" action of
        NoOp ->
            ( app, Cmd.none )

        TrackList msg ->
            let
                ( state, cmd ) =
                    TrackList.Update.update msg app.trackList
            in
                ( { app | trackList = state }, Cmd.none )

        UpdateSearch query ->
            ( { app | search = { value = query } }, search app.search.value )

        PlayTrack track ->
            ( { app | currentTrack = Just track }, play True )
