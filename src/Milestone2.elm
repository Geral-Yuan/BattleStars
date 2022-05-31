module Milestone2 exposing (..)

import Debug exposing (toString)
import Html exposing (..)
import Html.Attributes as HtmlAttr exposing (..)
import Svg exposing (Svg)
import Svg.Attributes as SvgAttr





type alias Scoreboard =
    {
        player_score : Int
        , player_lives : Int
    }

type Dir
    =  Left
    | Right

type alias Brick =
    { pos : ( Float, Float )
      , brick_lives : Int   -- (minus for infinite; >=0 for finite), when 0, delete the brick!
      , brick_score : Int
    }


type alias Paddle =
    { pos : ( Float, Float )
    , dir : Dir
    , height : Float
    , width : Float
    }


type alias Ball =
    { pos : ( Float, Float )
    , radius : Float
    , theta : Float
    , speed : Float
    }


type alias Model =
    { list_brick : List Brick
    , paddle : Paddle
    , ball : Ball
    , time : Float
    , scoreboard : Scoreboard 
    }



-- main : Program () Model msg
-- main =
--     Browser.element {init = init, update = update, view = view, subscriptions = Sub.none}
--


init : () -> ( Model, Cmd msg )
init _ =
    ( initModel, Cmd.none )


initModel : Model
initModel =
    { list_brick = initBrick ( 5, 10 ) 1 10 --one life for each brick; 10 points for each brick
    , paddle = Paddle ( 50, 90 ) Left 2 15  
    , ball = Ball ( 50, 50 ) 1.5 (pi/4) 1   --initial theta = pi/4; --initial speed = 1, adjust it if too fast or slow!! 
    , time = 0
    , scoreboard = initScoreboard 3     --three lives for a player
    }

initScoreboard : Int -> Scoreboard
initScoreboard lives = 
    Scoreboard 0 lives

initBrick : ( Float, Float ) -> Int -> Int -> List Brick
initBrick ( row, col ) lives score=
    if row == 1 then
        initBrickRow ( row, col ) lives score

    else
        initBrickRow ( row, col ) lives score ++ initBrick ( row - 1, col ) lives score


initBrickRow : ( Float, Float ) -> Int -> Int -> List Brick
initBrickRow ( row, col ) lives score=
    if col == 1 then
        [ Brick ( row, col ) lives score ]

    else
        Brick ( row, col ) lives score :: initBrickRow ( row, col - 1 ) lives score



-- adjust to screen size later


brickwidth : Float
brickwidth =
    10


brickheight : Float
brickheight =
    5


viewBricks : Brick -> Svg msg
viewBricks brick =
    let
        ( row, col ) =
            brick.pos
    in
    -- add if condition of bricks existence later
    Svg.rect
        [ SvgAttr.width (toString brickwidth ++ "%")
        , SvgAttr.height (toString brickheight ++ "%")
        , SvgAttr.x (toString ((col - 1) * brickwidth) ++ "%")
        , SvgAttr.y (toString ((row - 1) * brickheight + 5) ++ "%")
        , SvgAttr.fill "rgb(104,91,209)"
        , SvgAttr.stroke "white"
        ]
        []


view : Model -> Html msg
view model =
    div
        [ HtmlAttr.style "width" "100%"
        , HtmlAttr.style "height" "100%"
        , HtmlAttr.style "position" "fixed"
        , HtmlAttr.style "left" "0"
        , HtmlAttr.style "top" "0"
        ]
        [ Svg.svg
            [ SvgAttr.width "100%"
            , SvgAttr.height "100%"
            ]
            -- draw bricks
            (List.map viewBricks model.list_brick
                ++ -- draw paddle
                   Svg.rect
                        [ SvgAttr.width (toString model.paddle.width ++ "%")
                        , SvgAttr.height (toString model.paddle.height ++ "%")
                        , SvgAttr.x (toString (Tuple.first model.paddle.pos) ++ "%")
                        , SvgAttr.y (toString (Tuple.second model.paddle.pos) ++ "%")
                        , SvgAttr.fill "rgb(255,203,11)"
                        ]
                        []
                :: -- draw ball
                    [ Svg.circle
                        [ SvgAttr.cx ((toString (Tuple.first model.ball.pos)) ++ "%")
                        , SvgAttr.cy ((toString (Tuple.second model.ball.pos)) ++ "%")
                        , SvgAttr.r ((toString model.ball.radius) ++ "%")
                        , SvgAttr.fill "rgb(0,44,89)"
                        ]
                        []
                    ]
            )

        -- draw ball
        ]


main : Html msg
main =
    view initModel
