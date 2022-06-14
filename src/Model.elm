module Model exposing (..)

import Bounce exposing (..)
import Browser.Dom exposing (getViewport)
import Messages exposing (..)
import Paddle exposing (..)
import Random exposing (..)
import Scoreboard exposing (..)
import Task
import Data exposing (..)


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





init : () -> ( Model, Cmd Msg )
init _ =
    ( initModel
    , Task.perform GetViewport getViewport
    )

--wyj
initModel : Model
initModel =
    { list_brick = (initBrick ( 3, 5 ) brickLives 10 Water ) ++ (initBricktest ( 3, 5 ) (brickLives) 10 Fire)--one life for each brick; 10 points for each brick
    , paddle = { pos = ( 500, 1000 ), dir = Still, height = 20, width = paddleWidth, speed = 500, move_range = pixelWidth }
    , ball1 = generateBall ((initBrick ( 3, 5 ) brickLives 10 Water ) ++ (initBricktest ( 3, 5 ) brickLives 10 Fire)) (Random.initialSeed 1234) |> Tuple.first
    , ball2 = generateBall ((initBrick ( 3, 5 ) brickLives 10 Water ) ++ (initBricktest ( 3, 5 ) brickLives 10 Fire)) (Random.initialSeed 4321) |> Tuple.first
    , time = 0
    , scoreboard = initScoreboard 5 --five lives for a player
    , state = Starting
    , size = ( 2000, 1000 )
    , seed = Random.initialSeed 1234
    }

--wyj
restartModel : Model
restartModel =
    -- For players to select it when they click newGame
    { list_brick = (initBrick ( 3, 5 ) brickLives 10 Water ) ++ (initBricktest ( 3, 5 ) (brickLives) 10 Fire)--one life for each brick; 10 points for each brick
    , paddle = { pos = ( 500, 1000 ), dir = Still, height = 20, width = paddleWidth, speed = 500, move_range = pixelWidth }
    , ball1 = generateBall ((initBrick ( 3, 5 ) brickLives 10 Water ) ++ (initBricktest ( 3, 5 ) brickLives 10 Fire)) (Random.initialSeed 1234) |> Tuple.first
    , ball2 = generateBall ((initBrick ( 3, 5 ) brickLives 10 Water ) ++ (initBricktest ( 3, 5 ) brickLives 10 Fire)) (Random.initialSeed 4321) |> Tuple.first
    , time = 0
    , scoreboard = initScoreboard 5 --five lives for a player
    , state = Playing
    , size = ( 2000, 1000 )
    , seed = Random.initialSeed 1234
    }


initScoreboard : Int -> Scoreboard
initScoreboard lives =
    Scoreboard 0 lives


initBrick : ( Int, Int ) -> Int -> Int -> Element -> List Brick
initBrick ( row, col ) lives score element=
    if row == 1 then
        initBrickRow ( row, col ) lives score element

    else
        initBrickRow ( row, col ) lives score element ++ initBrick ( row - 1, col ) lives score element


initBrickRow : ( Int, Int ) -> Int -> Int -> Element -> List Brick
initBrickRow ( row, col ) lives score element=
    if col == 1 then
        [ Brick ( row, col ) lives score element]

    else
        Brick ( row, col ) lives score element :: initBrickRow ( row, col - 1 ) lives score element

initBricktest : ( Int, Int ) -> Int -> Int -> Element -> List Brick
initBricktest ( row, col ) lives score element=
    if row == 1 then
        initBrickRowtest ( row, col+5 ) lives score element

    else
        initBrickRowtest ( row, col+5 ) lives score element ++ initBricktest ( row - 1, col+5 ) lives score element


initBrickRowtest : ( Int, Int ) -> Int -> Int -> Element -> List Brick
initBrickRowtest ( row, col ) lives score element=
    if col == 6 then
        [ Brick ( row, col ) lives score element]

    else
        Brick ( row, col ) lives score element :: initBrickRowtest ( row, col - 1 ) lives score element
