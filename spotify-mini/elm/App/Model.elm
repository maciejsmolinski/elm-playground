module App.Model exposing (App, initial, update)

import TrackList.Model exposing (TrackList)
import Track.Model exposing (Track)
import Search.Model exposing (Search)
import App.Msg exposing (Msg(..))
import Ports.Ports exposing (search, play)


type alias App =
    { trackList : TrackList
    , currentTrack : Maybe Track
    , search : Search
    }


empty : App
empty =
    App TrackList.Model.initial Nothing Search.Model.initial


initial : ( App, Cmd Msg )
initial =
    ( empty, Cmd.none )


update : Msg -> App -> ( App, Cmd Msg )
update action app =
    case Debug.log "Message" action of
        NoOp ->
            ( app, Cmd.none )

        ClearTrackList ->
            ( { app | trackList = TrackList.Model.empty }, Cmd.none )

        UpdateTrackList trackList ->
            ( { app | trackList = (app.trackList ++ trackList) }, Cmd.none )

        UpdateSearch query ->
            ( { app | search = { value = query } }, search app.search.value )

        PlayTrack track ->
            ( { app | currentTrack = Just track }, play True )
