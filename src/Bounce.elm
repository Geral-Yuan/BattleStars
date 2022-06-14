module Bounce exposing (..)


import Messages exposing (..)
import Paddle exposing (..)
import Random exposing (..)
import Data exposing (..)




generateBall : List Brick -> Seed -> ( Ball, Seed )
generateBall brick_list seed =
    let
        ( ( row, col ), nseed ) =
            Random.step (Random.uniform ( 5, 9 ) (lowestBricks brick_list 10)) seed

        ( x, y ) =
            ( toFloat col * brickwidth - 50, toFloat (row + 1) * brickheight + 20 )
    in
    ( Ball ( x, y ) 15 200 200 { red = 0, green = 0, blue = 0 } Water, nseed )

lowestBricks : List Brick -> Int -> List ( Int, Int )
lowestBricks brick_list n =
    if n == 1 then
        [ lowestBrickCol brick_list n ]

    else
        lowestBrickCol brick_list n
            :: lowestBricks brick_list (n - 1)


lowestBrickCol : List Brick -> Int -> ( Int, Int )
lowestBrickCol brick_list n =
    let
        llist_pos =
            sameColumn brick_list n
    in
    Maybe.withDefault ( 1000, 1000 ) (List.head (List.reverse llist_pos))


sameColumn : List Brick -> Int -> List ( Int, Int )
sameColumn brick_list n =
    List.filter (\{ pos } -> Tuple.second pos == n) brick_list
        |> List.map .pos
        |> List.sortBy Tuple.first


changePos : ( Float, Float ) -> ( Float, Float ) -> ( Float, Float )
changePos ( x, y ) ( dx, dy ) =
    ( x + dx, y + dy )

--wyj
newBounceVelocity : Ball -> Bounce -> Ball
newBounceVelocity ball bounce =
    let
        speed = Tuple.first (toPolar (ball.v_x, ball.v_y) )
    in
    case bounce of
        Back ->
            { ball | v_y = -ball.v_y, v_x = -ball.v_x }

        Horizontal ->
            { ball | v_y = -ball.v_y }

        Vertical ->
            { ball | v_x = -ball.v_x }
        Paddle_Bounce rel_x ->
            {ball | v_x = Tuple.first (newPaddleBounceVelocity speed rel_x)
                   ,v_y = Tuple.second (newPaddleBounceVelocity speed rel_x)}
        _ ->
            ball
--wyj
newPaddleBounceVelocity : Float -> Float -> (Float, Float)
newPaddleBounceVelocity speed rel_x =
    let
        min_theta = pi/12
        theta = (min_theta + rel_x * (pi - 2 * min_theta) / paddleWidth)
        (n_vx, n_vy) = fromPolar (speed , theta)
    in
        (-n_vx , -n_vy)
        
--wyj--deductlife 1 means deduct only one life
updateBrick : Msg -> List Brick -> List Brick
updateBrick msg brick_list =
    case msg of
        Hit ( x, y ) ball_elem->
            (
            Tuple.second (List.partition (\{ pos } -> pos == ( x, y )) brick_list)
            ++ List.map (deductBrickLife ball_elem) (Tuple.first (List.partition (\{ pos } -> pos == ( x, y )) brick_list))
            )
            |>clearDeadBrick
        _ ->
            brick_list

deductBrickLife : Element -> Brick -> Brick
deductBrickLife ball_elem brick =
    {brick | brick_lives = brick.brick_lives - (elementMatch ball_elem brick.element)}

isBrickLife : Brick -> Bool
isBrickLife brick =
    if brick.brick_lives <= 0 then
        False
    else
        True

getBrickElement : Brick -> Element
getBrickElement brick =
    brick.element
clearDeadBrick : List(Brick) -> List(Brick)
clearDeadBrick brick_list =
    Tuple.first (List.partition (isBrickLife) brick_list)
