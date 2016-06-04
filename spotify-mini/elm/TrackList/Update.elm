module TrackList.Update exposing (update)

import TrackList.Model exposing (TrackList, empty)
import TrackList.Msg exposing (Msg(..))
import Track.Update


update : Msg -> TrackList -> ( TrackList, Cmd Msg )
update msg trackList =
    case msg of
        NoOp ->
            ( trackList, Cmd.none )

        ClearTrackList ->
            ( empty, Cmd.none )

        UpdateTrackList tracks ->
            ( trackList ++ tracks, Cmd.none )

        Track msg ->
            let
                mapped =
                    List.map (Track.Update.update msg) trackList

                tracks =
                    List.map fst mapped

                cmds =
                    List.map snd mapped
            in
                ( tracks, Cmd.map Track (Cmd.batch cmds) )
