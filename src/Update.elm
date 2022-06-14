module Update exposing (..)

import Bounce exposing (..)
import Browser.Dom exposing (getViewport)
import Messages exposing (..)
import Model exposing (..)
import Paddle exposing (..)
import Scoreboard exposing (..)
import Task
import Data exposing (..)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Start ->
            ( restartModel, Task.perform GetViewport getViewport )

        Resize width height ->
            ( { model | size = ( toFloat width, toFloat height ) }
            , Cmd.none
            )

        GetViewport { viewport } ->
            ( { model
                | size =
                    ( viewport.width
                    , viewport.height
                    )
              }
            , Cmd.none
            )
        
        _ ->
            ( model, Cmd.none )
                |> updatePaddle msg
                |> updateBall msg
                |> updateTime msg
                |> checkEnd

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
                | paddle = transPaddle model }
                    
              
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
getTerminal : Model -> Float
getTerminal  model =
    let
        nmodel =
            bounceAll ( model, Cmd.none )
            |> Tuple.first
        ball1 = model.ball1       --找更下面的ball
        cy1 = Tuple.second (ball1.pos)
        ball2 = model.ball2       --找更下面的ball
        cy2 = Tuple.second (ball2.pos)
        paddle = model.paddle
        py=Tuple.second (paddle.pos)

    in
    if (cy1 + ball1.radius <= py) && (cy2 + ball2.radius <= py) then
        getTerminal (moveBall nmodel (0.01) )
    else

        if (cy1 + ball1.radius > py) then
            (model.ball1.pos
            |> Tuple.first)
            - paddle.width /2
        else
            (model.ball2.pos
            |> Tuple.first)
            - paddle.width /2

transPaddle : Model -> Paddle
transPaddle model = 
    let
        paddle = model.paddle
        py = Tuple.second (paddle.pos)
        
    in
    { paddle | pos = (getTerminal model, py)}
-- By Yuan Jiale, update ball


updateBall : Msg -> ( Model, Cmd Msg ) -> ( Model, Cmd Msg )
updateBall msg ( model, cmd ) =
    let
        ( nmodel, ncmd ) =
            bounceAll ( model, cmd )
    in
    case msg of
        Tick elapsed ->
            ( moveBall nmodel (elapsed / 1000), ncmd )

        _ ->
            ( nmodel, ncmd )


moveBall : Model -> Float -> Model
moveBall model dt =
    let
        ball1 =
            model.ball1

        ball2 =
            model.ball2

        nball1 =
            { ball1 | pos = changePos ball1.pos ( ball1.v_x * dt, ball1.v_y * dt ) }

        nball2 =
            { ball2 | pos = changePos ball2.pos ( ball2.v_x * dt, ball2.v_y * dt ) }
    in
    { model | ball1 = nball1, ball2 = nball2 }


bounceAll :
    ( Model, Cmd Msg )
    -> ( Model, Cmd Msg ) --generate the model after bouncing
bounceAll ( model, cmd ) =
    ( model, cmd )
        |> bouncePaddle
        |> bounceScreen
        |> bounceBrick


bouncePaddle : ( Model, Cmd Msg ) -> ( Model, Cmd Msg )
bouncePaddle ( model, cmd ) =
    let
        ball1 =
            model.ball1

        ball2 =
            model.ball2

        paddle =
            model.paddle

        bounce1 =
            checkBouncePaddle ball1 paddle

        bounce2 =
            checkBouncePaddle ball2 paddle

        new_ball1 =
            newBounceVelocity ball1 bounce1

        new_ball2 =
            newBounceVelocity ball2 bounce2
    in
    ( { model | ball1 = new_ball1, ball2 = new_ball2 }, cmd )

--wyj
checkBouncePaddle : Ball -> Paddle -> Bounce
checkBouncePaddle ball paddle =
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
        ball1 =
            model.ball1

        ball2 =
            model.ball2

        bounce1 =
            checkBounceScreen ball1

        bounce2 =
            checkBounceScreen ball2

        nball1 =
            newBounceVelocity ball1 bounce1

        nball2 =
            newBounceVelocity ball2 bounce2
    in
    ( { model | ball1 = nball1, ball2 = nball2 }, cmd )


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

    else if (x - r <= 0 && ball.v_x < 0) || (x + r >= 10 * brickwidth && ball.v_x > 0) then
        Vertical

    else
        None
findHitBrick : Msg -> List(Brick) -> Maybe Brick
findHitBrick msg list_brick=
    case msg of
        Hit (x,y) element ->
            Tuple.first (List.partition (\{ pos } -> pos == ( x, y )) list_brick)
            |> List.head
        _ ->
            Nothing
changeElement : Ball -> Maybe Brick -> Ball
changeElement  ball brick  = 
    case brick of
        Just bk ->
            {ball| element = bk.element
            }
        Nothing ->
            ball
    
    

--wyj改的有问题
bounceBrick : ( Model, Cmd Msg ) -> ( Model, Cmd Msg )
bounceBrick ( model, cmd ) =
    let
        ball1 =
            model.ball1

        ball2 =
            model.ball2

        ele1 = ball1.element

        ele2 = ball2.element
        list_brick =
            model.list_brick

        -- Added the scoring system here
        oldScore =
            model.scoreboard.player_score

        nScore =
            oldScore + getBrick_score (Hit pos1 ele1) list_brick

        oldScoreboard =
            model.scoreboard

        nScoreboard =
            { oldScoreboard | player_score = nScore }

        ( bounce1, pos1 ) =
            checkBounceBrickList ball1 list_brick

        nlist_brick =
            updateBrick (Hit pos1 ele1) list_brick

        nnScore =
            nScore + getBrick_score (Hit pos2 ele2) nlist_brick

        nnScoreboard =
            { nScoreboard | player_score = nnScore }

        ( bounce2, pos2 ) =
            checkBounceBrickList ball2 nlist_brick
        
        eleball1 = (findHitBrick (Hit pos1 ele1) nlist_brick
                |> changeElement ball1)
        eleball2 = (findHitBrick (Hit pos2 ele2) nlist_brick
                |> changeElement ball2)
        
        nball1 =
            newBounceVelocity
                eleball1
                bounce1
            

        nball2 =
            newBounceVelocity
                eleball2
                bounce2
    in
    ( { model | ball1 = 
                 nball1
                , ball2 =  nball2
                , list_brick = updateBrick (Hit pos2 ele2) nlist_brick, scoreboard = nnScoreboard }, cmd )


checkBounceBrickList : Ball -> List Brick -> ( Bounce, ( Int, Int ) )
checkBounceBrickList ball list_brick =
    let
        kickedBrickList =
            Tuple.first (List.partition (\brick -> List.member (checkBounceBrick ball brick) [ Horizontal, Vertical ]) list_brick)
    in
    case kickedBrickList of
        [] ->
            ( None, ( 0, 0 ) )

        kickedBrick :: _ ->
            ( checkBounceBrick ball kickedBrick, kickedBrick.pos )


checkBounceBrick : Ball -> Brick -> Bounce
checkBounceBrick ball brick =
    let
        ( row, column ) =
            brick.pos

        x =
            toFloat (column - 1) * brickwidth

        y =
            toFloat (row - 1) * brickheight + 50

        --? what's the meaning of 50????
        ( bx, by ) =
            ball.pos

        r =
            ball.radius
    in
    if by >= y + brickheight && by - r <= y + brickheight && bx >= x && bx <= x + brickwidth && ball.v_y < 0 then
        Horizontal

    else if by <= y && by + r >= y && bx >= x && bx <= x + brickwidth && ball.v_y > 0 then
        Horizontal

    else if bx <= x && bx + r >= x && by >= y && by <= y + brickheight && ball.v_x > 0 then
        Vertical

    else if bx >= x + brickwidth && bx - r <= x + brickwidth && by >= y && by <= y + brickheight && ball.v_x < 0 then
        Vertical

    else
        None


updateTime : Msg -> ( Model, Cmd Msg ) -> ( Model, Cmd Msg )
updateTime msg ( model, cmd ) =
    case msg of
        Tick elapse ->
            ( { model | time = model.time + elapse / 1000 }, cmd )

        _ ->
            ( model, cmd )


checkEnd : ( Model, Cmd Msg ) -> ( Model, Cmd Msg )
checkEnd ( model, cmd ) =
    let
        prev_ball1 =
            model.ball1

        prev_ball2 =
            model.ball2

        ( _, y1 ) =
            prev_ball1.pos

        ( _, y2 ) =
            prev_ball2.pos

        prev_sb =
            model.scoreboard

        prev_pl =
            prev_sb.player_lives
    in
    if y1 >= 1100 then
        if prev_pl <= 1 then
            ( { model
                | ball1 = { prev_ball1 | v_x = 0, v_y = 0 }
                , ball2 = { prev_ball2 | v_x = 0, v_y = 0 }
                , scoreboard = { prev_sb | player_lives = prev_pl - 1 }
                , state = Gameover
              }
            , cmd
            )

        else
            ( { model
                | ball1 = generateBall model.list_brick model.seed |> Tuple.first
                , scoreboard = { prev_sb | player_lives = prev_pl - 1 }
                , seed = generateBall model.list_brick model.seed |> Tuple.second
              }
            , cmd
            )

    else if y2 >= 1100 then
        if prev_pl <= 1 then
            ( { model
                | ball1 = { prev_ball1 | v_x = 0, v_y = 0 }
                , ball2 = { prev_ball2 | v_x = 0, v_y = 0 }
                , scoreboard = { prev_sb | player_lives = prev_pl - 1 }
                , state = Gameover
              }
            , cmd
            )

        else
            ( { model
                | ball2 = generateBall model.list_brick model.seed |> Tuple.first
                , scoreboard = { prev_sb | player_lives = prev_pl - 1 }
                , seed = generateBall model.list_brick model.seed |> Tuple.second
              }
            , cmd
            )

    else if List.length model.list_brick == 0 then
        ( { model
            | ball1 = { prev_ball1 | v_x = 0, v_y = 0 }
            , ball2 = { prev_ball1 | v_x = 0, v_y = 0 }
            , state = Gameover
          }
        , cmd
        )

    else
        ( model, cmd )
