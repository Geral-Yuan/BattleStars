module Model exposing (..)

import Bounce exposing (..)
import Browser.Dom exposing (getViewport)
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
    { list_brick : List Brick
    , paddle : Paddle
    , ball1 : Ball
    , ball2 : Ball
    , time : Float
    , scoreboard : Scoreboard
    , state : State
    , size : ( Float, Float )
    , seed : Seed
    }


pixelWidth : Float
pixelWidth =
    1000


pixelHeight : Float
pixelHeight =
    1200


init : () -> ( Model, Cmd Msg )
init _ =
    ( initModel
    , Task.perform GetViewport getViewport
    )


initModel : Model
initModel =
    { list_brick = initBrick ( 3, 10 ) 1 10 --one life for each brick; 10 points for each brick
    , paddle = { pos = ( 500, 1000 ), dir = Still, height = 20, width = 150, speed = 500 }
    , ball1 = generateBall (initBrick ( 5, 10 ) 1 10) (Random.initialSeed 1234) |> Tuple.first
    , ball2 = generateBall (initBrick ( 5, 10 ) 1 10) (Random.initialSeed 4321) |> Tuple.first
    , time = 0
    , scoreboard = initScoreboard 5 --five lives for a player
    , state = Starting
    , size = ( 2000, 1000 )
    , seed = Random.initialSeed 1234
    }


restartModel : Model
restartModel =
    -- For players to select it when they click newGame
    { list_brick = initBrick ( 3, 10 ) 1 10 --one life for each brick; 10 points for each brick
    , paddle = { pos = ( 500, 1000 ), dir = Still, height = 20, width = 150, speed = 500 }
    , ball1 = generateBall (initBrick ( 5, 10 ) 1 10) (Random.initialSeed 1234) |> Tuple.first
    , ball2 = generateBall (initBrick ( 5, 10 ) 1 10) (Random.initialSeed 4321) |> Tuple.first
    , time = 0
    , scoreboard = initScoreboard 5 --five lives for a player
    , state = Playing
    , size = ( 2000, 1000 )
    , seed = Random.initialSeed 1234
    }


initScoreboard : Int -> Scoreboard
initScoreboard lives =
    Scoreboard 0 lives


initBrick : ( Int, Int ) -> Int -> Int -> List Brick
initBrick ( row, col ) lives score =
    if row == 1 then
        initBrickRow ( row, col ) lives score

    else
        initBrickRow ( row, col ) lives score ++ initBrick ( row - 1, col ) lives score


initBrickRow : ( Int, Int ) -> Int -> Int -> List Brick
initBrickRow ( row, col ) lives score =
    if col == 1 then
        [ Brick ( row, col ) lives score ]

    else
        Brick ( row, col ) lives score :: initBrickRow ( row, col - 1 ) lives score
