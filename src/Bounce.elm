module Bounce exposing (..)

import Data exposing (..)
import Messages exposing (..)
import Paddle exposing (..)
import Random exposing (..)


generateBall : Paddle -> Seed -> ( Ball, Seed )
generateBall paddle seed =
    let
        ( elem, nseed ) =
            Random.step (Random.uniform Water [ Fire, Grass, Earth ]) seed

        ( x, y ) =
            addVec paddle.pos ( paddle.width / 2, 0 )
    in
    ( Ball ( x, y ) 15 0 300 { red = 0, green = 0, blue = 0 } elem, nseed )


changePos : ( Float, Float ) -> ( Float, Float ) -> ( Float, Float )
changePos ( x, y ) ( dx, dy ) =
    ( x + dx, y + dy )



--wyj


newBounceVelocity : Ball -> Bounce -> Ball
newBounceVelocity ball bounce =
    let
        speed =
            Tuple.first (toPolar ( ball.v_x, ball.v_y ))
    in
    case bounce of
        Back ->
            { ball | v_y = -ball.v_y, v_x = -ball.v_x }

        Horizontal ->
            { ball | v_y = -ball.v_y }

        Vertical ->
            { ball | v_x = -ball.v_x }

        Paddle_Bounce rel_x ->
            { ball
                | v_x = Tuple.first (newPaddleBounceVelocity speed rel_x)
                , v_y = Tuple.second (newPaddleBounceVelocity speed rel_x)
            }

        _ ->
            ball



--wyj


newPaddleBounceVelocity : Float -> Float -> ( Float, Float )
newPaddleBounceVelocity speed rel_x =
    let
        min_theta =
            pi / 12

        theta =
            min_theta + rel_x * (pi - 2 * min_theta) / paddleWidth

        ( n_vx, n_vy ) =
            fromPolar ( speed, theta )
    in
    ( -n_vx, -n_vy )



--wyj--deductlife 1 means deduct only one life


updateMonster : Msg -> List Monster -> List Monster
updateMonster msg monster_list =
    case msg of
        Hit idx_ ball_elem ->
            (Tuple.second (List.partition (\{ idx } -> idx == idx_) monster_list)
                ++ List.map (deductMonsterLife ball_elem) (Tuple.first (List.partition (\{ idx } -> idx == idx_) monster_list))
            )
                |> clearDeadMonster

        _ ->
            monster_list


deductMonsterLife : Element -> Monster -> Monster
deductMonsterLife ball_elem monster =
    { monster | monster_lives = monster.monster_lives - elementMatch ball_elem monster.element }


isMonsterLife : Monster -> Bool
isMonsterLife monster =
    if monster.monster_lives <= 0 then
        False

    else
        True


getMonsterElement : Monster -> Element
getMonsterElement monster =
    monster.element


clearDeadMonster : List Monster -> List Monster
clearDeadMonster monster_list =
    Tuple.first (List.partition isMonsterLife monster_list)
