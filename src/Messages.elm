module Messages exposing (..)

import Browser.Dom exposing (Viewport)
import Data exposing (Element)


type Dir
    = Left
    | Right
    | Still --Still added because we are updating with Tick

--wyj
type Msg
    = Key Dir Bool
    | Key_None
    | Trans
    | Tick Float
    | GetViewport Viewport
    | Resize Int Int
    | Hit Int Element
    | New_Element Element
    | Start



