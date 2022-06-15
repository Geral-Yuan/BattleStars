module Update exposing (..)

import Bounce exposing (..)
import Browser.Dom exposing (getViewport)
import Data exposing (..)
import Html.Attributes exposing (multiple)
import Messages exposing (..)
import Model exposing (..)
import Paddle exposing (..)
import Scoreboard exposing (..)
import Svg.Attributes exposing (by)
import Task


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Restart ->
            ( playModel model model.state, Task.perform GetViewport getViewport )

        Resize width height ->
            ( { model | size = ( toFloat width, toFloat height ) }
            , Cmd.none
            )

        Start ->
            ( sceneModel model Scene11, Task.perform GetViewport getViewport )

        GetViewport { viewport } ->
            ( { model
                | size =
                    ( viewport.width
                    , viewport.height
                    )
              }
            , Cmd.none
            )

        Enter ->
            updateScene model

        _ ->
            ( model, Cmd.none )
                |> updatePaddle msg
                |> updateBall msg
                |> updateTime msg
                |> checkFail
                |> checkBallNumber
                |> checkEnd


updateScene : Model -> ( Model, Cmd Msg )
updateScene model =
    case model.state of
        Scene11 ->
            let
                nModel =
                    initModel
            in
            ( { nModel | state = Scene12 }, Task.perform GetViewport getViewport )

        Scene12 ->
            let
                nModel =
                    initModel
            in
            ( { nModel | state = Playing1 }, Task.perform GetViewport getViewport )

        Scene2 ->
            let
                nModel =
                    initModel
            in
            ( { nModel | state = Playing2 }, Task.perform GetViewport getViewport )

        Scene3 ->
            let
                nModel =
                    initModel
            in
            ( { nModel | state = Playing3 }, Task.perform GetViewport getViewport )

        Scene4 ->
            let
                nModel =
                    initModel
            in
            ( { nModel | state = Playing4 }, Task.perform GetViewport getViewport )

        Scene5 ->
            let
                nModel =
                    initModel
            in
            ( { nModel | state = Playing5 }, Task.perform GetViewport getViewport )

        Victory ->
            let
                nModel =
                    initModel
            in
            ( { nModel | state = Gameover }, Task.perform GetViewport getViewport )

        _ ->
            ( model, Task.perform GetViewport getViewport )



--wyj


updatePaddle : Msg -> ( Model, Cmd Msg ) -> ( Model, Cmd Msg )
updatePaddle msg ( model, cmd ) =
    case msg of
        Tick elapse ->
            ( { model
                | paddle =
                    movePaddle model.paddle (elapse / 1000)
              }
            , cmd
            )

        Trans ->
            ( { model
                | paddle = transPaddle model
              }
            , cmd
            )

        Key dir on ->
            ( { model
                | paddle =
                    updatePaddleDir model.paddle dir on
              }
            , cmd
            )

        _ ->
            ( model, cmd )



--wyj
-- getTerminal : Model -> Float
-- getTerminal  model =
--     let
--         nmodel =
--             bounceAll ( model, Cmd.none )
--             |> Tuple.first
--         ball = model.ball       --找更下面的ball
--         cy = Tuple.second (ball.pos)
--         paddle = model.paddle
--         py=Tuple.second (paddle.pos)
--     in
--     if cy + ball.radius <= py then
--         getTerminal (moveBall nmodel (0.01) )
--     else
--         (model.ball.pos
--         |> Tuple.first)
--         - paddle.width /2
--wyj
-- a function that let paddle catch ball automatically


getTerminal : Model -> Float
getTerminal model =
    let
        nmodel =
            bounceAll ( model, Cmd.none )
                |> Tuple.first

        py =
            Tuple.second model.paddle.pos
    in
    case List.filter (\ball -> Tuple.second ball.pos + ball.radius > py) model.ball_list |> List.head of
        Nothing ->
            getTerminal (moveBall nmodel 0.01)

        Just ball ->
            Tuple.first ball.pos - model.paddle.width / 2


transPaddle : Model -> Paddle
transPaddle model =
    let
        paddle =
            model.paddle

        py =
            Tuple.second paddle.pos
    in
    { paddle | pos = ( getTerminal model, py ) }



-- By Yuan Jiale, update ball


updateBall : Msg -> ( Model, Cmd Msg ) -> ( Model, Cmd Msg )
updateBall msg ( model, cmd ) =
    let
        ( nmodel, ncmd ) =
            bounceAll ( model, cmd )
    in
    case msg of
        Tick elapsed ->
            ( moveMonster (moveBall nmodel (elapsed / 1000)) (elapsed / 1000), ncmd )

        _ ->
            ( nmodel, ncmd )


moveBall : Model -> Float -> Model
moveBall model dt =
    let
        nball_list =
            List.map (\ball -> { ball | pos = changePos ball.pos ( ball.v_x * dt, ball.v_y * dt ) }) model.ball_list
    in
    { model | ball_list = nball_list }


bounceAll :
    ( Model, Cmd Msg )
    -> ( Model, Cmd Msg ) --generate the model after bouncing
bounceAll ( model, cmd ) =
    ( model, cmd )
        |> bouncePaddle
        |> bounceScreen
        |> bounceMonster


bouncePaddle : ( Model, Cmd Msg ) -> ( Model, Cmd Msg )
bouncePaddle ( model, cmd ) =
    let
        nball_list =
            List.map2 newBounceVelocity model.ball_list (List.map (checkBouncePaddle <| model.paddle) model.ball_list)
    in
    ( { model | ball_list = nball_list }, cmd )



--wyj


checkBouncePaddle : Paddle -> Ball -> Bounce
checkBouncePaddle paddle ball =
    let
        r =
            ball.radius

        ( bx, by ) =
            ball.pos

        ( px, py ) =
            paddle.pos

        wid =
            paddle.width
    in
    if ball.v_y > 0 then
        if by <= py && by + r >= py && bx >= px && bx <= px + wid then
            Paddle_Bounce (bx - px)

        else if bx <= px && bx + r >= px && by >= py && by <= py + paddle.height then
            Back

        else if bx >= px + paddle.width && bx - r <= px + paddle.width && by >= py && by <= py + paddle.height then
            Back

        else
            None

    else
        None


bounceScreen : ( Model, Cmd Msg ) -> ( Model, Cmd Msg )
bounceScreen ( model, cmd ) =
    let
        nball_list =
            List.map2 newBounceVelocity model.ball_list (List.map checkBounceScreen model.ball_list)
    in
    ( { model | ball_list = nball_list }, cmd )


checkBounceScreen : Ball -> Bounce
checkBounceScreen ball =
    let
        r =
            ball.radius

        ( x, y ) =
            ball.pos
    in
    if y - r <= 50 && ball.v_y < 0 then
        --chayan
        Horizontal

    else if (x - r <= 0 && ball.v_x < 0) || (x + r >= 10 * monsterwidth && ball.v_x > 0) then
        Vertical

    else
        None


findHitMonster : List Monster -> Msg -> Maybe Monster
findHitMonster monster_list msg =
    case msg of
        Hit k _ ->
            Tuple.first (List.partition (\{ idx } -> idx == k) monster_list)
                |> List.head

        _ ->
            Nothing


changeElement : Ball -> Maybe Monster -> Ball
changeElement ball monster =
    case monster of
        Just bk ->
            { ball
                | element = bk.element
            }

        Nothing ->
            ball


bounceMonster : ( Model, Cmd Msg ) -> ( Model, Cmd Msg )
bounceMonster ( model, cmd ) =
    let
        matidx_list =
            List.map (checkBounceMonsterList model.monster_list) model.ball_list

        mat_list =
            List.map Tuple.first matidx_list

        idx_list =
            List.map Tuple.second matidx_list

        elem_list =
            List.map (\ball -> ball.element) model.ball_list

        msg_list =
            List.map2 Hit idx_list elem_list

        nmonster_list =
            List.foldr updateMonster model.monster_list msg_list

        nscore =
            List.foldr (+) model.scores (List.map (getMonster_score model.monster_list) msg_list)

        elemball_list =
            List.map2 changeElement model.ball_list (List.map (findHitMonster model.monster_list) msg_list)

        nball_list =
            List.map2 newReflectedVelocity elemball_list mat_list
    in
    ( { model
        | ball_list = nball_list
        , monster_list = nmonster_list
        , scores = nscore
      }
    , cmd
    )


checkBounceMonsterList : List Monster -> Ball -> ( Mat, Int )
checkBounceMonsterList monster_list ball =
    let
        kickedMonsterList =
            List.filter (\monster -> checkBounceMonster ball monster /= identityMat) monster_list
    in
    case kickedMonsterList of
        [] ->
            ( identityMat, 0 )

        kickedMonster :: _ ->
            ( checkBounceMonster ball kickedMonster, kickedMonster.idx )


checkBounceMonster : Ball -> Monster -> Mat
checkBounceMonster ball monster =
    let
        ( x, y ) =
            monster.pos

        ( bx, by ) =
            ball.pos

        br =
            ball.radius

        mr =
            monster.monster_radius
    in
    if (x - bx) ^ 2 + (y - by) ^ 2 <= (br + mr) ^ 2 && innerVec ( x - bx, y - by ) ( ball.v_x, ball.v_y ) >= 0 then
        reflectionMat ( -(y - by), x - bx )

    else
        identityMat


updateTime : Msg -> ( Model, Cmd Msg ) -> ( Model, Cmd Msg )
updateTime msg ( model, cmd ) =
    case msg of
        Tick elapse ->
            ( { model | time = model.time + elapse / 1000 }, cmd )

        _ ->
            ( model, cmd )


checkFail : ( Model, Cmd Msg ) -> ( Model, Cmd Msg )
checkFail ( model, cmd ) =
    let
        ( belowBall, upBall ) =
            List.partition (\ball -> Tuple.second ball.pos >= 1100) model.ball_list
    in
    case belowBall |> List.head of
        Nothing ->
            ( model, cmd )

        Just _ ->
            ( { model
                | ball_list = upBall
              }
            , cmd
            )


checkBallNumber : ( Model, Cmd Msg ) -> ( Model, Cmd Msg )
checkBallNumber ( model, cmd ) =
    if List.length model.ball_list < model.ballnumber then
        checkBallNumber
            ( { model
                | ball_list = (generateBall model.paddle model.seed |> Tuple.first) :: model.ball_list
                , lives = model.lives - 1
                , seed = generateBall model.paddle model.seed |> Tuple.second
              }
            , cmd
            )

    else
        ( model, cmd )


checkEnd : ( Model, Cmd Msg ) -> ( Model, Cmd Msg )
checkEnd ( model, cmd ) =
    if model.lives == 0 then
        ( { model
            | state = Gameover
          }
        , cmd
        )

    else if List.isEmpty model.monster_list then
        ( { model
            | ball_list = List.map (\ball -> { ball | v_x = 0, v_y = 0 }) model.ball_list
            , state = Gameover
          }
        , cmd
        )

    else
        ( model, cmd )
