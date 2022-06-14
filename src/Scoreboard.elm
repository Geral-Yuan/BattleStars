module Scoreboard exposing (..)

import Bounce exposing (..)
import Data exposing (Brick)
import Messages exposing (..)



-- Scoreboard system done by Jovan


getBrick_score : List Brick -> Msg -> Int
getBrick_score list_brick msg=
    case msg of
        Hit ( x, y ) ball_element ->
            -- extract the list from the tuple and then acquire the brick_score
            Maybe.withDefault 0 (List.head (List.map .brick_score (Tuple.first (List.partition (\{ pos } -> pos == ( x, y )) list_brick))))

        _ ->
            0
