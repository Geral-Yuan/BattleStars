module Paddle exposing (..)

import Messages exposing(..)
import Data exposing (..)

type alias Paddle =
    { pos : ( Float, Float )
    , dir : Dir
    , height : Float
    , width : Float
    , speed : Float
    , move_range : Float
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
--wyj
isLegalMovePaddle : Paddle -> Bool
isLegalMovePaddle { pos, dir, width, move_range} =
    case dir of 
        Left ->
            if ( Tuple.first pos <= 0) then
                False
            else
                True
        Right ->
            if ( Tuple.first pos + width >= move_range) then  --the right bound of the game screen
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


