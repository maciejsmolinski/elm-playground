module App.Update exposing (update)

import App.Model exposing (App)
import App.Msg exposing (Msg(..))
import TrackList.Update
import Search.Update


update : Msg -> App -> ( App, Cmd Msg )
update action app =
    case Debug.log "Message" action of
        NoOp ->
            ( app, Cmd.none )

        TrackList msg ->
            let
                ( state, cmd ) =
                    TrackList.Update.update msg app.trackList

                currentTrack =
                    List.head
                        <| List.filter (.current) state
            in
                ( { app | trackList = state, currentTrack = currentTrack }, Cmd.map TrackList cmd )

        Search msg ->
            let
                ( state, cmd ) =
                    (Search.Update.update msg app.search)
            in
                ( { app | search = state }, Cmd.map Search cmd )

        Player _ ->
            ( app, Cmd.none )
