module Scoreboard exposing (..)

import Bounce exposing (..)
import Messages exposing (..)


type alias Scoreboard =
    { player_score : Int
    , player_lives : Int
    }



-- Scoreboard system done by Jovan


getBrick_score : Msg -> List Brick -> Int
getBrick_score msg list_brick =
    case msg of
        Hit ( x, y ) ->
            -- extract the list from the tuple and then acquire the brick_score
            Maybe.withDefault 0 (List.head (List.map .brick_score (Tuple.first (List.partition (\{ pos } -> pos == ( x, y )) list_brick))))

        _ ->
            0
