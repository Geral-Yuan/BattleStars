module Model exposing (..)

import Browser.Dom exposing (getViewport)
import Data exposing (..)
import Messages exposing (..)
import Paddle exposing (..)
import Random exposing (..)
import Scoreboard exposing (..)
import Task


type State
    = Starting
    | Playing1 -- Playing will be switched to Playing1, Playing2 (different levels)
    | Playing2
    | Playing3
    | Playing4
    | Playing5
    | Scene11
    | Scene12
    | Scene2
    | Scene3
    | Scene4
    | Scene5
    | Victory
    | Gameover


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


playModel : Model -> State -> Model
playModel model state =
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
    , state = state
    , size = ( 2000, 1000 )
    , seed = Random.initialSeed 1234
    }


sceneModel : Model -> State -> Model
sceneModel model state =
    -- to change scenes
    { monster_list = initMonsterList 12 --one life for each monster; 10 points for each monster
    , paddle = initpaddle
    , ball_list =
        [ generateBall initpaddle (Random.initialSeed 1234) |> Tuple.first
        ]
    , ballnumber = 1
    , time = 0
    , lives = 5 --five lives for a player
    , scores = 0
    , state = state
    , size = ( 2000, 1000 )
    , seed = Random.initialSeed 1234
    }


generateBall : Paddle -> Seed -> ( Ball, Seed )
generateBall paddle seed =
    let
        ( elem, nseed ) =
            Random.step
                (Random.uniform Water
                    [ Fire

                    {- , Grass, Earth -}
                    ]
                )
                seed

        ( x, y ) =
            addVec paddle.pos ( paddle.width / 2, -15 )
    in
    ( Ball ( x, y ) 15 0 -300 { red = 0, green = 0, blue = 0 } elem, nseed )


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


detVelocity : Monster -> ( Float, Float )
detVelocity monster =
    if Tuple.second monster.pos <= 700 then
        ( 0, 15 )

    else
        ( 0, 10 )
