module Update exposing (..)

import Bounce exposing (..)
import Messages exposing (..)
import Model exposing (..)
import Paddle exposing (..)
import Scoreboard exposing (..)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model
    , Cmd.none
    )
        |> updatePaddle msg
        |> updateBall msg
        |> updateTime msg


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

        Key dir on ->
            ( { model
                | paddle =
                    updatePaddleDir model.paddle dir on
              }
            , cmd
            )

        _ ->
            ( model, cmd )



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
        ball =
            model.ball

        nball =
            { ball | pos = changePos ball.pos ( ball.v_x * dt, ball.v_y * dt ) }
    in
    { model | ball = nball }


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
        ball =
            model.ball

        paddle =
            model.paddle

        bounce =
            checkBouncePaddle ball paddle

        new_ball =
            newBounceVelocity ball bounce paddle
    in
    ( { model | ball = new_ball }, cmd )


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
    if by <= py && by + r >= py && bx >= px && bx <= px + wid then
        Horizontal

    else if bx <= px && bx + r >= px && by >= py && by <= py + paddle.height then
        Back

    else if bx >= px + paddle.width && bx - r <= px + paddle.width && by >= py && by <= py + paddle.height then
        Back

    else
        None


bounceScreen : ( Model, Cmd Msg ) -> ( Model, Cmd Msg )
bounceScreen ( model, cmd ) =
    let
        ball =
            model.ball

        bounce =
            checkBounceScreen ball

        paddle =
            model.paddle

        nball =
            newBounceVelocity ball bounce paddle
    in
    ( { model | ball = nball }, cmd )


checkBounceScreen : Ball -> Bounce
checkBounceScreen ball =
    let
        r =
            ball.radius

        ( x, y ) =
            ball.pos
    in
    if y - r <= 50 then
        --chayan
        Horizontal

    else if x - r <= 0 || x + r >= 10 * brickwidth then
        Vertical

    else
        None


bounceBrick : ( Model, Cmd Msg ) -> ( Model, Cmd Msg )
bounceBrick ( model, cmd ) =
    let
        ball =
            model.ball

        list_brick =
            model.list_brick

        paddle =
            model.paddle

        -- Added the scoring system here
        oldScore =
            model.scoreboard.player_score

        nScore =
            oldScore + getBrick_score (Hit pos) list_brick

        oldScoreboard =
            model.scoreboard

        nScoreboard =
            { oldScoreboard | player_score = nScore }

        ( bounce, pos ) =
            checkBounceBrickList ball list_brick

        nball =
            newBounceVelocity ball bounce paddle
    in
    ( { model | ball = nball, list_brick = updateBrick (Hit pos) list_brick, scoreboard = nScoreboard }, cmd )


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
    if by >= y + brickheight && by - r <= y + brickheight && bx >= x && bx <= x + brickwidth then
        Horizontal

    else if by <= y && by + r >= y && bx >= x && bx <= x + brickwidth then
        Horizontal

    else if bx <= x && bx + r >= x && by >= y && by <= y + brickheight then
        Vertical

    else if bx >= x + brickwidth && bx - r <= x + brickwidth && by >= y && by <= y + brickheight then
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
