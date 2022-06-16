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
            ( initLevel model.level model, Task.perform GetViewport getViewport )

        Resize width height ->
            ( { model | size = ( toFloat width, toFloat height ) }
            , Cmd.none
            )

        Start ->
            let
                ( nmodel, _ ) =
                    updateClearLevel model
            in
            updateScene nmodel

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
            case model.state of
                Scene _ ->
                    -- let
                    --     (nmodel, _) = updateClearLevel model
                    -- in
                    updateScene model

                ClearLevel _ ->
                    let
                        ( nmodel, _ ) =
                            updateClearLevel model
                    in
                    updateScene nmodel

                _ ->
                    ( model, Cmd.none )

        Skip ->
            case model.state of
                Playing _ ->
                    let
                        nModel =
                            model
                    in
                    ( { nModel | state = ClearLevel model.level }, Task.perform GetViewport getViewport )

                _ ->
                    ( model, Cmd.none )

        Shoot ->
            ( shootBall model, Cmd.none )

        _ ->
            ( model, Cmd.none )
                |> updatePaddle msg
                |> updateBall
                |> moveStuff msg
                |> updateTime msg
                |> checkFail
                |> checkBallNumber
                |> checkEnd


updateScene : Model -> ( Model, Cmd Msg )
updateScene model =
    case model.state of
        Scene 1 ->
            let
                nModel =
                    model
            in
            ( { nModel | state = Scene 2 }, Task.perform GetViewport getViewport )

        Scene 2 ->
            -- let
            --     nModel =
            --         model
            -- in
            ( initLevel 1 model, Task.perform GetViewport getViewport )

        -- ( { nModel | state = Playing 1 }, Task.perform GetViewport getViewport )
        -- Playing 1 ->
        --     ( initLevel 1 model , Task.perform GetViewport getViewport)
        -- Scene 3 ->
        --     let
        --         nModel =
        --             model
        --     in
        --     ( { nModel | state = Playing 2 }, Task.perform GetViewport getViewport )
        Scene 3 ->
            ( initLevel 2 model, Task.perform GetViewport getViewport )

        Scene 4 ->
            -- let
            --     nModel =
            --         model
            -- in
            -- ( { nModel | state = Playing 3 }, Task.perform GetViewport getViewport )
            ( initLevel 3 model, Task.perform GetViewport getViewport )

        Scene 5 ->
            -- let
            --     nModel =
            --         model
            -- in
            -- ( { nModel | state = Playing 4 }, Task.perform GetViewport getViewport )
            ( initLevel 4 model, Task.perform GetViewport getViewport )

        Scene 6 ->
            -- let
            --     nModel =
            --         model
            -- in
            -- ( { nModel | state = Playing 5 }, Task.perform GetViewport getViewport )
            ( initLevel 5 model, Task.perform GetViewport getViewport )

        Scene 7 ->
            -- let
            --     nModel =
            --         model
            -- in
            -- ( { nModel | state = Starting }, Task.perform GetViewport getViewport )
            ( initLevel 6 model, Task.perform GetViewport getViewport )

        _ ->
            ( model, Task.perform GetViewport getViewport )


updateClearLevel : Model -> ( Model, Cmd Msg )
updateClearLevel model =
    case model.state of
        Starting ->
            let
                nModel =
                    model
            in
            ( { nModel | state = Scene 1 }, Task.perform GetViewport getViewport )

        ClearLevel 1 ->
            let
                nModel =
                    model
            in
            ( { nModel | state = Scene 3 }, Task.perform GetViewport getViewport )

        ClearLevel 2 ->
            let
                nModel =
                    model
            in
            ( { nModel | state = Scene 4 }, Task.perform GetViewport getViewport )

        ClearLevel 3 ->
            let
                nModel =
                    model
            in
            ( { nModel | state = Scene 5 }, Task.perform GetViewport getViewport )

        ClearLevel 4 ->
            let
                nModel =
                    model
            in
            ( { nModel | state = Scene 6 }, Task.perform GetViewport getViewport )

        ClearLevel 5 ->
            let
                nModel =
                    model
            in
            ( { nModel | state = Scene 7 }, Task.perform GetViewport getViewport )

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


shootBall : Model -> Model
shootBall model =
    let
        ( carryedBall, freeBall ) =
            List.partition (\ball -> ball.state == Carryed) model.ball_list

        shootedBall =
            List.head carryedBall

        otherBall =
            List.drop 1 carryedBall ++ freeBall
    in
    case shootedBall of
        Just ball ->
            { model | ball_list = { ball | state = Free, v_y = -600 } :: otherBall }

        Nothing ->
            model



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
            getTerminal (moveBall 0.01 nmodel)

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


updateBall : ( Model, Cmd Msg ) -> ( Model, Cmd Msg )
updateBall ( model, cmd ) =
    bounceAll ( model, cmd )


moveStuff : Msg -> ( Model, Cmd Msg ) -> ( Model, Cmd Msg )
moveStuff msg ( model, cmd ) =
    case msg of
        Tick elapsed ->
            ( model
                |> moveBall (elapsed / 1000)
                |> moveMonster (elapsed / 1000)
                |> moveBoss (elapsed / 1000)
            , cmd
            )

        _ ->
            ( model, cmd )


moveBall : Float -> Model -> Model
moveBall dt model =
    let
        nball_list =
            List.map (moveEachBall dt model.paddle) model.ball_list
    in
    { model | ball_list = nball_list }


moveEachBall : Float -> Paddle -> Ball -> Ball
moveEachBall dt paddle ball =
    case ball.state of
        Free ->
            { ball | pos = changePos ball.pos ( ball.v_x * dt, ball.v_y * dt ) }

        Carryed ->
            { ball | pos = addVec paddle.pos ( paddle.width / 2, -15 ) }


moveMonster : Float -> Model -> Model
moveMonster dt model =
    let
        nmonster_list =
            List.map (\monster -> { monster | pos = addVec monster.pos (scaleVec dt (detVelocity monster model)) }) model.monster_list
    in
    monsterHitSurface { model | monster_list = nmonster_list }


monsterHitSurface : Model -> Model
monsterHitSurface model =
    let
        ( dead, alive ) =
            model.monster_list
                |> List.partition (\{ pos } -> Tuple.second pos >= 920)

        deducted_lives =
            2 * List.length dead

        prev_lives =
            model.lives
    in
    { model | monster_list = alive, lives = prev_lives - deducted_lives }


moveBoss : Float -> Model -> Model
moveBoss dt model =
    let
        boss =
            model.boss

        nboss =
            { boss | pos = addVec boss.pos (scaleVec dt (detVelocityBoss boss model.state)) }
    in
    { model | boss = nboss }


bounceAll : ( Model, Cmd Msg ) -> ( Model, Cmd Msg )
bounceAll ( model, cmd ) =
    ( model, cmd )
        |> bouncePaddle
        |> bounceScreen
        |> bounceMonster
        |> bounceBoss


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
    if y - r <= 0 && ball.v_y < 0 then
        Horizontal

    else if (x - r <= 0 && ball.v_x < 0) || (x + r >= 1000 && ball.v_x > 0) then
        Vertical

    else
        None


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
            List.foldr (+) model.level_scores (List.map (getMonster_score model.monster_list) msg_list)

        elemball_list =
            List.map2 changeElement model.ball_list (List.map (findHitMonster model.monster_list) msg_list)

        nball_list =
            List.map2 newReflectedVelocity elemball_list mat_list
    in
    ( { model
        | ball_list = nball_list
        , monster_list = nmonster_list
        , level_scores = nscore
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

        r =
            monster.monster_radius
    in
    if (x - bx) ^ 2 + (y - by) ^ 2 <= (br + r) ^ 2 && innerVec ( x - bx, y - by ) ( ball.v_x, ball.v_y ) >= 0 && ball.state == Free then
        reflectionMat ( -(y - by), x - bx )

    else
        identityMat


bounceBoss : ( Model, Cmd Msg ) -> ( Model, Cmd Msg )
bounceBoss ( model, cmd ) =
    let
        mat_list =
            List.map (checkBounceBoss model.boss) model.ball_list

        nball_list =
            List.map2 newReflectedVelocity model.ball_list mat_list
    in
    ( { model | ball_list = nball_list }
    , cmd
    )


checkBounceBoss : Boss -> Ball -> Mat
checkBounceBoss boss ball =
    let
        ( x, y ) =
            boss.pos

        ( bx, by ) =
            ball.pos

        br =
            ball.radius

        r =
            boss.boss_radius
    in
    if (x - bx) ^ 2 + (y - by) ^ 2 <= (br + r) ^ 2 && innerVec ( x - bx, y - by ) ( ball.v_x, ball.v_y ) >= 0 then
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
    let
        elemNum =
            case model.level of
                1 ->
                    1

                2 ->
                    2

                _ ->
                    4
    in
    if List.length model.ball_list < model.ballnumber then
        checkBallNumber
            ( { model
                | ball_list = (generateBall model.paddle model.seed elemNum |> Tuple.first) :: model.ball_list
                , lives = model.lives - 1
                , seed = generateBall model.paddle model.seed elemNum |> Tuple.second
              }
            , cmd
            )

    else
        ( model, cmd )


checkEnd : ( Model, Cmd Msg ) -> ( Model, Cmd Msg )
checkEnd ( model, cmd ) =
    if model.lives == 0 then
        ( { model
            | state = Gameover model.level
          }
        , cmd
        )

    else if List.isEmpty model.monster_list then
        ( { model
            | ball_list = List.map (\ball -> { ball | v_x = 0, v_y = 0 }) model.ball_list
            , state = ClearLevel model.level
            , scores = model.scores + model.level_scores
            , level_scores = 0
          }
        , Cmd.batch [ cmd, Task.perform GetViewport getViewport ]
        )
        -- ( { nModel | state = ClearLevel model.level }, Task.perform GetViewport getViewport )
        -- Add one more condition here to check for Victory

    else
        ( model, cmd )
