module Paddle exposing (..)

import Messages exposing(..)


type alias Paddle =
    { pos : ( Float, Float )
    , dir : Dir
    , height : Float
    , width : Float
    , speed : Float
    }



updatePaddleDir : Paddle -> Dir -> Bool -> Paddle
updatePaddleDir paddle dir on =
    if on then
        {paddle | dir = dir}
    else
        {paddle | dir = Still}
        

movePaddle : Paddle -> Float -> Paddle
movePaddle paddle dt=
    case paddle.dir of
        Still ->
            paddle
        _ -> if (isLegalMovePaddle paddle) then
                { paddle | pos = newPaddlePos paddle.pos paddle.dir (paddle.speed * dt )}
             else
                paddle
isLegalMovePaddle : Paddle -> Bool
isLegalMovePaddle { pos, dir, width} =
    case dir of 
        Left ->
            if ( Tuple.first pos <= 0) then
                False
            else
                True
        Right ->
            if ( Tuple.first pos + width >= 10 * brickwidth) then  --the right bound of the game screen
                False
            else
                True
        _ -> False

newPaddlePos : (Float, Float) -> Dir -> Float -> (Float, Float)
newPaddlePos (px,py) dir ds=
    case dir of
        Left ->
            (px - ds , py)
        Right ->
            (px + ds , py)
        _ -> 
            (px,py)