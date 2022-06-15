module Data exposing (..)

import Color exposing (Color)
import Svg.Attributes exposing (numOctaves, speed, x2, y1, y2)


monsterwidth : Float
monsterwidth =
    100


monsterheight : Float
monsterheight =
    100


monsterLives : Int
monsterLives =
    4


pixelWidth : Float
pixelWidth =
    1000


pixelHeight : Float
pixelHeight =
    1200


paddleWidth : Float
paddleWidth =
    150


paddleSpeed : Float
paddleSpeed =
    800


type Bounce
    = Horizontal
    | Vertical
    | Back
    | Paddle_Bounce Float
    | None


type Element
    = Water
    | Fire
    | Grass
    | Earth
    | Element_None


type alias Monster =
    { idx : Int
    , pos : ( Float, Float )
    , monster_lives : Int
    , monster_score : Int
    , monster_radius : Float
    , element : Element
    }


type alias Ball =
    { pos : ( Float, Float )
    , radius : Float
    , v_x : Float
    , v_y : Float
    , color : Color
    , element : Element
    }


type alias Vec =
    ( Float, Float )


type alias Mat =
    ( Vec, Vec )


identityMat : Mat
identityMat =
    ( ( 1, 0 ), ( 0, 1 ) )


addVec : Vec -> Vec -> Vec
addVec ( x1, y1 ) ( x2, y2 ) =
    ( x1 + x2, y1 + y2 )


scaleVec : Float -> Vec -> Vec
scaleVec k ( x, y ) =
    ( k * x, k * y )


innerVec : Vec -> Vec -> Float
innerVec ( x1, y1 ) ( x2, y2 ) =
    x1 * x2 + y1 * y2


reflectionMat : Vec -> Mat
reflectionMat ( bx, by ) =
    let
        t =
            ( ( bx, -by ), ( by, bx ) )

        a =
            ( ( 1, 0 ), ( 0, -1 ) )

        br2 =
            bx ^ 2 + by ^ 2

        t_ =
            ( ( bx / br2, by / br2 ), ( -by / br2, bx / br2 ) )
    in
    multiMatMat (multiMatMat t a) t_


multiMatVec : Mat -> Vec -> Vec
multiMatVec ( a1, a2 ) v =
    ( innerVec a1 v, innerVec a2 v )


multiMatMat : Mat -> Mat -> Mat
multiMatMat ( ( a11, a12 ), ( a21, a22 ) ) ( ( b11, b12 ), ( b21, b22 ) ) =
    ( ( a11 * b11 + a12 * b21, a11 * b12 + a12 * b22 ), ( a21 * b11 + a22 * b21, a21 * b12 + a22 * b22 ) )


elementMatch : Element -> Element -> Int
elementMatch ball_elem monster_elem =
    let
        match =
            ( ball_elem, monster_elem )
    in
    case match of
        ( Water, Fire ) ->
            4

        ( Fire, Grass ) ->
            4

        ( Grass, Earth ) ->
            4

        ( Earth, Water ) ->
            4

        ( Fire, Water ) ->
            1

        ( Grass, Fire ) ->
            1

        ( Earth, Grass ) ->
            1

        ( Water, Earth ) ->
            1

        _ ->
            2


element2ColorString : Element -> String
element2ColorString elem =
    case elem of
        Water ->
            "blue"

        Fire ->
            "red"

        Grass ->
            "green"

        Earth ->
            "brown"

        Element_None ->
            "white"
