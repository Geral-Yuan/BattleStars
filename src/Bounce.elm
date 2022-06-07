module Bounce exposing (..)

import Color exposing (Color)
import Messages exposing (..)
import Paddle exposing (..)


type Bounce
    = Horizontal
    | Vertical
    | Back
    | None


type alias Brick =
    { pos : ( Int, Int )
    , brick_lives : Int -- (minus for infinite; >=0 for finite), when 0, delete the brick!
    , brick_score : Int
    }


type alias Ball =
    { pos : ( Float, Float )
    , radius : Float
    , v_x : Float
    , v_y : Float
    , color : Color
    }


changePos : ( Float, Float ) -> ( Float, Float ) -> ( Float, Float )
changePos ( x, y ) ( dx, dy ) =
    ( x + dx, y + dy )


newBounceVelocity : Ball -> Bounce -> Paddle -> Ball
newBounceVelocity ball bounce paddle =
    case bounce of
        Back ->
            { ball | v_y = -ball.v_y, v_x = -ball.v_x }

        Horizontal ->
            if Tuple.second ball.pos + ball.radius >= Tuple.second paddle.pos && ball.v_y < 0 then
                ball

            else
                { ball | v_y = -ball.v_y }

        Vertical ->
            if (ball.v_x < 0 && Tuple.first ball.pos + ball.radius > 10 * brickwidth) || (ball.v_x > 0 && Tuple.first ball.pos - ball.radius < 0) then
                ball

            else
                { ball | v_x = -ball.v_x }

        None ->
            ball


updateBrick : Msg -> List Brick -> List Brick
updateBrick msg list_brick =
    case msg of
        Hit ( x, y ) ->
            Tuple.second (List.partition (\{ pos } -> pos == ( x, y )) list_brick)

        _ ->
            list_brick
