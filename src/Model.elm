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
    | Playing Int -- Playing will be switched to Playing1, Playing2 (different levels)
    | Scene Int
    | ClearLevel Int -- Input level integer
    | Gameover Int


type alias Model =
    { monster_list : List Monster
    , boss : Boss
    , paddle : Paddle
    , ball_list : List Ball
    , ballnumber : Int
    , time : Float
    , lives : Int
    , scores : Int
    , state : State
    , size : ( Float, Float )
    , seed : Seed
    , level : Int
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( initModel
    , Task.perform GetViewport getViewport
    )


initModel : Model
initModel =
    { monster_list = initMonsterList 12 --one life for each monster; 10 points for each monster
    , boss = initBoss
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
    , level = 0
    }


initLevel : Int -> Model -> Model
initLevel k model =
    case k of
        1 ->
            model

        2 ->
            model

        _ ->
            model


playModel : Model -> Int -> Model
playModel model level =
    -- For players to select it when they click newGame
    { monster_list = initMonsterList 12 --one life for each monster; 10 points for each monster
    , boss = initBoss
    , paddle = initpaddle
    , ball_list =
        [ generateBall initpaddle (Random.initialSeed 1234) |> Tuple.first
        ]
    , ballnumber = 1
    , time = 0
    , lives = 5 --five lives for a player
    , scores = 0
    , state = Playing level
    , size = ( 2000, 1000 )
    , seed = Random.initialSeed 1234
    , level = 0
    }


sceneModel : Model
sceneModel =
    -- to change scenes
    { monster_list = initMonsterList 12 --one life for each monster; 10 points for each monster
    , boss = initBoss
    , paddle = initpaddle
    , ball_list =
        [ generateBall initpaddle (Random.initialSeed 1234) |> Tuple.first
        ]
    , ballnumber = 1
    , time = 0
    , lives = 5 --five lives for a player
    , scores = 0
    , state = Scene 1
    , size = ( 2000, 1000 )
    , seed = Random.initialSeed 1234
    , level = 1
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


initBoss : Boss
initBoss =
    Boss ( 500, -1250 ) 1250 -1


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
            modBy 4 (idx - 1) + 1
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
    ( 0, 10 )


detVelocityBoss : Boss -> ( Float, Float )
detVelocityBoss boss =
    ( 0, 10 )
