module App.Model exposing (App, initial, empty)

import TrackList.Model exposing (TrackList)
import Track.Model exposing (Track)
import Search.Model exposing (Search)
import Routing.Model exposing (Routing)
import App.Msg exposing (Msg(..))


type alias App =
    { trackList : TrackList
    , currentTrack : Maybe Track
    , search : Search
    , routing : Routing
    }


empty : App
empty =
    App TrackList.Model.initial Nothing Search.Model.initial Routing.Model.initial


initial : ( App, Cmd Msg )
initial =
    ( empty, Cmd.none )
