module App.Model exposing (App, initial, update)

import TrackList.Model exposing (TrackList)
import Search.Model exposing (Search)
import App.Action exposing (Action(..))
import Ports.Ports exposing (search)


type alias App =
    { trackList : TrackList
    , search : Search
    }


empty : App
empty =
    App TrackList.Model.initial Search.Model.initial


initial : ( App, Cmd Action )
initial =
    ( empty, Cmd.none )


update : Action -> App -> ( App, Cmd Action )
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
