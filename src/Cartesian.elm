module Cartesian exposing (..)

{- This module contains everything related to Vector Spaces and checkViewSize -}


type alias Vector =
    ( Float, Float )


checkViewSize : Vector -> Float
checkViewSize ( x, y ) =
    -- to create a size of page field in model record
    -- change the ratio according
    if x / y >= 7 / 6 then
        if y / 600 < 0.1 then
            1

        else
            y / 600

    else if x / 700 < 0.1 then
        1

    else
        x / 700
