module Bounce exposing (..)

import Color exposing (Color)
import Messages exposing (..)
import Paddle exposing (..)
import Random exposing (..)


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


generateBall : List Brick -> Seed -> ( Ball, Seed )
generateBall list_brick seed =
    let
        ( ( row, col ), nseed ) =
            Random.step (Random.uniform ( 5, 9 ) (lowestBricks list_brick 10)) seed

        ( x, y ) =
            ( toFloat col * brickwidth - 50, toFloat (row + 1) * brickheight + 20 )
    in
    ( Ball ( x, y ) 15 200 200 { red = 0, green = 0, blue = 0 }, nseed )


lowestBricks : List Brick -> Int -> List ( Int, Int )
lowestBricks list_brick n =
    if n == 1 then
        [ lowestBrickCol list_brick n ]

    else
        lowestBrickCol list_brick n
            :: lowestBricks list_brick (n - 1)


lowestBrickCol : List Brick -> Int -> ( Int, Int )
lowestBrickCol list_brick n =
    let
        llist_pos =
            sameColumn list_brick n
    in
    Maybe.withDefault ( 1000, 1000 ) (List.head (List.reverse llist_pos))


sameColumn : List Brick -> Int -> List ( Int, Int )
sameColumn list_brick n =
    List.filter (\{ pos } -> Tuple.second pos == n) list_brick
        |> List.map .pos
        |> List.sortBy Tuple.first


changePos : ( Float, Float ) -> ( Float, Float ) -> ( Float, Float )
changePos ( x, y ) ( dx, dy ) =
    ( x + dx, y + dy )


newBounceVelocity : Ball -> Bounce -> Ball
newBounceVelocity ball bounce =
    case bounce of
        Back ->
            { ball | v_y = -ball.v_y, v_x = -ball.v_x }

        Horizontal ->
            { ball | v_y = -ball.v_y }

        Vertical ->
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
