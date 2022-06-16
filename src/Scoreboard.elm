module Scoreboard exposing (..)

import Data exposing (..)
import Messages exposing (..)



-- Scoreboard system done by Jovan


getMonster_score : List Monster -> Msg -> Int
getMonster_score list_monster msg =
    case msg of
        Hit idx_ ball_element ->
            -- extract the list from the tuple and then acquire the monster_score
            (hitMonster idx_ list_monster
                |> .monster_score
            )
                * (hitMonster idx_ list_monster
                    |> .element
                    |> elementMatch ball_element
                    |> bonusScore
                  )

        _ ->
            0


hitMonster : Int -> List Monster -> Monster
hitMonster idx_ list_monster =
    let
        sample_monster =
            Monster 100 ( -1, -1 ) -1 0 0 Element_None
    in
    List.partition (\{ idx } -> idx == idx_) list_monster
        |> Tuple.first
        |> List.head
        |> Maybe.withDefault sample_monster


bonusScore : Int -> Int
bonusScore eff =
    case eff of
        1 ->
            1

        2 ->
            2

        4 ->
            5

        _ ->
            0
