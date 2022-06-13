module Data exposing (..)

import Color exposing (Color)
brickwidth : Float
brickwidth =
    100


brickheight : Float
brickheight =
    100

brickLives : Int
brickLives = 4

pixelWidth : Float
pixelWidth =
    1000


pixelHeight : Float
pixelHeight =
    1200

paddleWidth : Float
paddleWidth = 150

paddleSpeed : Float
paddleSpeed = 800


type Bounce
    = Horizontal
    | Vertical
    | Back
    | Paddle_Bounce Float 
    | None
type Element =
    Water
    | Fire
    | Grass
    | Earth
    | Element_None

type alias Brick =
    { pos : ( Int, Int )
    , brick_lives : Int -- (minus for infinite; >=0 for finite), when 0, delete the brick!
    , brick_score : Int
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

elementMatch : Element -> Element -> Int
elementMatch ball_ele brick_ele =
    let 
        match = (ball_ele , brick_ele)
    in
    case match of 
        (Water, Fire) ->
            4
        (Fire, Grass) ->
            4
        (Grass, Earth) ->
            4
        (Earth, Water) ->
            4
        (Fire, Water) ->
            1
        (Grass, Fire) ->
            1
        (Earth, Grass) ->
            1
        (Water, Earth) ->
            1
        _ ->
            2
element2ColorString : Element -> String
element2ColorString element =
    case element of
            Water ->
                "blue"
            Fire ->
                "red"
            Grass ->
                "green"
            Earth ->
                "yellow"
            Element_None ->
                "white"