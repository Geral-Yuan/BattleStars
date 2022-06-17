module Messages exposing (..)

import Browser.Dom exposing (Viewport)
import Data exposing (Element)


type Dir
    = Left
    | Right



--wyj


type Msg
    = Key Dir Bool
    | Key_None
    | Enter Bool
    | Shoot Bool
      -- | Trans
    | Tick Float
    | GetViewport Viewport
    | Resize Int Int
    | Hit Int Element
    | New_Element Element
    | Restart -- Restart level if player loses
    | Start
    | Skip -- For debugging
    | NextScene
    | GenerateMonster Element ( Float, Float )
