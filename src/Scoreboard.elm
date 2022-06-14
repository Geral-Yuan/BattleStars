module Scoreboard exposing (..)

import Bounce exposing (..)
import Data exposing (Monster)
import Messages exposing (..)



-- Scoreboard system done by Jovan


getMonster_score : List Monster -> Msg -> Int
getMonster_score list_monster msg=
    case msg of
        Hit idx_ ball_element ->
            -- extract the list from the tuple and then acquire the monster_score
            Maybe.withDefault 0 (List.head (List.map .monster_score (Tuple.first (List.partition (\{ idx } -> idx == idx_) list_monster))))

        _ ->
            0
