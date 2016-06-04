module App.Update exposing (update)

import App.Model exposing (App)
import App.Msg exposing (Msg(..))
import TrackList.Update
import Ports.Ports exposing (search)


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

        UpdateSearch query ->
            ( { app | search = { value = query } }, search app.search.value )
