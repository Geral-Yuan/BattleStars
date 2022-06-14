module Model exposing (..)

import Bounce exposing (..)
import Browser.Dom exposing (getViewport)
import Data exposing (..)
import Messages exposing (..)
import Paddle exposing (..)
import Random exposing (..)
import Scoreboard exposing (..)
import Task


type State
    = Starting
    | Playing -- Playing will be switched to Playing1, Playing2 (different levels)
      -- | Scene Narrative
    | Gameover



-- type Narrative
--     = Logo
--     | HowtoPlay
--     | Level1
--     | Level2


type alias Model =
    { brick_list : List Brick
    , paddle : Paddle
    , ball_list : List Ball
    , time : Float
    , lives : Int
    , scores : Int
    , state : State
    , size : ( Float, Float )
    , seed : Seed
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( initModel
    , Task.perform GetViewport getViewport
    )


initModel : Model
initModel =
    { brick_list = initBrick ( 3, 5 ) brickLives 10 Water ++ initBricktest ( 3, 5 ) brickLives 10 Fire --one life for each brick; 10 points for each brick
    , paddle = { pos = ( 500, 1000 ), dir = Still, height = 20, width = paddleWidth, speed = 500, move_range = pixelWidth }
    , ball_list =
        [ generateBall (initBrick ( 3, 5 ) brickLives 10 Water ++ initBricktest ( 3, 5 ) brickLives 10 Fire) (Random.initialSeed 1234) |> Tuple.first
        , generateBall (initBrick ( 3, 5 ) brickLives 10 Water ++ initBricktest ( 3, 5 ) brickLives 10 Fire) (Random.initialSeed 4321) |> Tuple.first
        ]
    , time = 0
    , lives = 5 --five lives for a player
    , scores = 0
    , state = Starting
    , size = ( 2000, 1000 )
    , seed = Random.initialSeed 1234
    }


restartModel : Model
restartModel =
    -- For players to select it when they click newGame
    { brick_list = initBrick ( 3, 5 ) brickLives 10 Water ++ initBricktest ( 3, 5 ) brickLives 10 Fire --one life for each brick; 10 points for each brick
    , paddle = { pos = ( 500, 1000 ), dir = Still, height = 20, width = paddleWidth, speed = 500, move_range = pixelWidth }
    , ball_list =
        [ generateBall (initBrick ( 3, 5 ) brickLives 10 Water ++ initBricktest ( 3, 5 ) brickLives 10 Fire) (Random.initialSeed 1234) |> Tuple.first
        , generateBall (initBrick ( 3, 5 ) brickLives 10 Water ++ initBricktest ( 3, 5 ) brickLives 10 Fire) (Random.initialSeed 4321) |> Tuple.first
        ]
    , time = 0
    , lives = 5 --five lives for a player
    , scores = 0
    , state = Playing
    , size = ( 2000, 1000 )
    , seed = Random.initialSeed 1234
    }


initBrick : ( Int, Int ) -> Int -> Int -> Element -> List Brick
initBrick ( row, col ) lives score elem =
    if row == 1 then
        initBrickRow ( row, col ) lives score elem

    else
        initBrickRow ( row, col ) lives score elem ++ initBrick ( row - 1, col ) lives score elem


initBrickRow : ( Int, Int ) -> Int -> Int -> Element -> List Brick
initBrickRow ( row, col ) lives score elem =
    if col == 1 then
        [ Brick ( row, col ) lives score elem ]

    else
        Brick ( row, col ) lives score elem :: initBrickRow ( row, col - 1 ) lives score elem


initBricktest : ( Int, Int ) -> Int -> Int -> Element -> List Brick
initBricktest ( row, col ) lives score elem =
    if row == 1 then
        initBrickRowtest ( row, col + 5 ) lives score elem

    else
        initBrickRowtest ( row, col + 5 ) lives score elem ++ initBricktest ( row - 1, col + 5 ) lives score elem


initBrickRowtest : ( Int, Int ) -> Int -> Int -> Element -> List Brick
initBrickRowtest ( row, col ) lives score elem =
    if col == 6 then
        [ Brick ( row, col ) lives score elem ]

    else
        Brick ( row, col ) lives score elem :: initBrickRowtest ( row, col - 1 ) lives score elem
