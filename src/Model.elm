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
    { monster_list : List Monster
    , paddle : Paddle
    , ball_list : List Ball
    , ballnumber : Int
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
    { monster_list = initMonsterList 12 --one life for each monster; 10 points for each monster
    , paddle = initpaddle
    , ball_list =
        [ generateBall initpaddle (Random.initialSeed 1234) |> Tuple.first
        ]
    , ballnumber = 1
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
    { monster_list = initMonsterList 12 --one life for each monster; 10 points for each monster
    , paddle = initpaddle
    , ball_list =
        [ generateBall initpaddle (Random.initialSeed 1234) |> Tuple.first
        ]
    , ballnumber = 1
    , time = 0
    , lives = 5 --five lives for a player
    , scores = 0
    , state = Playing
    , size = ( 2000, 1000 )
    , seed = Random.initialSeed 1234
    }


initMonsterList : Int -> List Monster
initMonsterList n =
    case n of
        0 ->
            []

        _ ->
            initMonsterList (n - 1) ++ [ initMonster n ]


initpaddle : Paddle
initpaddle =
    { pos = ( 500, 1000 ), dir = Still, height = 20, width = paddleWidth, speed = 500, move_range = pixelWidth }

-- radius of monster is likely to be adjust to a suitable size later
initMonster : Int -> Monster
initMonster idx =
    Monster idx (detPosition idx) monsterLives 10 80 (detElem idx)


detPosition : Int -> ( Float, Float )
detPosition idx =
    let
        row =
            (idx - 1) // 4

        column =
            modBy 4 idx + 1
    in
    ( toFloat column * 200, toFloat row * 200 + 100 )


detElem : Int -> Element
detElem idx =
    if modBy 4 idx <= 1 then
        Water

    else
        Fire
