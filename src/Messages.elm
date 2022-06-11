module Messages exposing (..)

import Browser.Dom exposing (Viewport)
type Dir
    = Left
    | Right
    | Still --Still added because we are updating with Tick

type Msg
    = Key Dir Bool
    | Key_None
    | Tick Float
    | GetViewport Viewport
    | Resize Int Int
    | Hit ( Int, Int )
    | Start

brickwidth : Float
brickwidth =
    100


brickheight : Float
brickheight =
    50
