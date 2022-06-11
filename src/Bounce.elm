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
