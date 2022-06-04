module Test exposing (..)

import Browser
import Browser.Events exposing (onAnimationFrameDelta, onKeyDown)
import Debug exposing (toString)
import Html exposing (..)
import Html.Attributes as HtmlAttr exposing (..)
import Html.Events exposing (keyCode)
import Json.Decode as Decode
import Milestone2 exposing (brickheight, brickwidth)
import String exposing (left, pad)
import Svg exposing (Svg)
import Svg.Attributes as SvgAttr exposing (in_)


type alias Scoreboard =
    { player_score : Int
    , player_lives : Int
    }


type Bounce
    = Horizontal
    | Vertical
    | None


type Dir
    = Left
    | Right
    | Still --Still added because we are updating with Tick


type alias Brick =
    { pos : ( Int, Int )
    , brick_lives : Int -- (minus for infinite; >=0 for finite), when 0, delete the brick!
    , brick_score : Int
    }


type alias Paddle =
    { pos : ( Float, Float )
    , dir : Dir
    , height : Float
    , width : Float
    }


type alias Ball =
    { pos : ( Float, Float )
    , radius : Float
    , v_x : Float
    , v_y : Float
    }


type alias Model =
    { list_brick : List Brick
    , paddle : Paddle
    , ball : Ball
    , time : Float
    , scoreboard : Scoreboard
    }



----------
-- MSG
----------


type Msg
    = Key Dir
    | Key_None
    | Tick Float
    | Kick ( Int, Int )



----------
-- MAIN
----------


main : Program () Model Msg
main =
    Browser.element { init = init, view = view, update = update, subscriptions = subscriptions }



----------
-- INIT
----------


init : () -> ( Model, Cmd Msg )
init _ =
    ( initModel, Cmd.none )


initModel : Model
initModel =
    { list_brick = initBrick ( 5, 10 ) 1 10 --one life for each brick; 10 points for each brick
    , paddle = Paddle ( 50, 90 ) Left 2 15
    , ball = Ball ( 50, 50 ) 1.5 0.2 -0.2 --initial theta = pi/4; --initial speed = 1, adjust it if too fast or slow!!
    , time = 0
    , scoreboard = initScoreboard 3 --three lives for a player
    }


initScoreboard : Int -> Scoreboard
initScoreboard lives =
    Scoreboard 0 lives



-- To be improved


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



----------
-- UPDATE
----------


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    let
        npaddle =
            updatePaddle msg model.paddle

        ( nmodel, ncmd ) =
            updateBall msg ( model, Cmd.none )
    in
    ( { nmodel | paddle = npaddle, ball = nmodel.ball, list_brick = nmodel.list_brick }, ncmd )


updatePaddle : Msg -> Paddle -> Paddle
updatePaddle msg paddle =
    case msg of
        Key Left ->
            { paddle | pos = changePos paddle.pos ( -3, 0 ) }

        Key Right ->
            { paddle | pos = changePos paddle.pos ( 3, 0 ) }

        _ ->
            paddle


changePos : ( Float, Float ) -> ( Float, Float ) -> ( Float, Float )
changePos ( x, y ) ( dx, dy ) =
    ( x + dx, y + dy )


updateBall : Msg -> ( Model, Cmd Msg ) -> ( Model, Cmd Msg )
updateBall msg ( model, cmd ) =
    let
        ( nmodel, ncmd ) =
            bounceFunc ( model, cmd )
    in
    case msg of
        Tick elapsed ->
            ( moveBall { nmodel | time = nmodel.time + elapsed }, ncmd )

        _ ->
            ( nmodel, ncmd )


moveBall : Model -> Model
moveBall model =
    let
        ball =
            model.ball

        ( nball, ntime ) =
            if model.time > 15 then
                ( { ball | pos = changePos ball.pos ( ball.v_x, ball.v_y ) }, 0 )

            else
                ( ball, model.time )
    in
    { model | ball = nball, time = ntime }


updateBrick : Msg -> List Brick -> List Brick
updateBrick msg list_brick =
    case msg of
        Kick ( x, y ) ->
            Tuple.second (List.partition (\{ pos } -> pos == ( x, y )) list_brick)

        _ ->
            list_brick


bounceFunc : ( Model, Cmd Msg ) -> ( Model, Cmd Msg )
bounceFunc ( model, cmd ) =
    ( model, cmd )
        |> bouncePaddle
        |> bounceScreen
        |> bounceBrick


bounceVelocity : Ball -> Bounce -> Ball
bounceVelocity ball bounce =
    case bounce of
        Horizontal ->
            { ball | v_y = -ball.v_y }

        Vertical ->
            { ball | v_x = -ball.v_x }

        None ->
            ball


bouncePaddle : ( Model, Cmd Msg ) -> ( Model, Cmd Msg )
bouncePaddle ( model, cmd ) =
    let
        ball =
            model.ball

        paddle =
            model.paddle

        bounce =
            checkBouncePaddle ball paddle

        nball =
            bounceVelocity ball bounce
    in
    ( { model | ball = nball }, cmd )


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

    else
        None


bounceScreen : ( Model, Cmd Msg ) -> ( Model, Cmd Msg )
bounceScreen ( model, cmd ) =
    let
        ball =
            model.ball

        bounce =
            checkBounceScreen ball

        nball =
            bounceVelocity ball bounce
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
    if y - r <= 5 then
        Horizontal

    else if x - r <= 0 || x + r >= 100 then
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

        ( bounce, pos ) =
            checkBounceBrickList ball list_brick

        nball =
            bounceVelocity ball bounce
    in
    ( { model | ball = nball, list_brick = updateBrick (Kick pos) list_brick }, cmd )


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
            toFloat (row - 1) * brickheight + 5

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


brickwidth : Float
brickwidth =
    10


brickheight : Float
brickheight =
    5


viewBricks : Brick -> Svg msg
viewBricks brick =
    let
        ( row, col ) =
            brick.pos
    in
    -- add if condition of bricks existence later
    Svg.rect
        [ SvgAttr.width (toString brickwidth ++ "%")
        , SvgAttr.height (toString brickheight ++ "%")
        , SvgAttr.x (toString (toFloat (col - 1) * brickwidth) ++ "%")
        , SvgAttr.y (toString (toFloat (row - 1) * brickheight + 5) ++ "%")
        , SvgAttr.fill "rgb(104,91,209)"
        , SvgAttr.stroke "white"
        ]
        []


viewScore : Model -> Html Msg
viewScore model =
    div
        [ -- style "background" "#34495f"
          -- , style "border" "0"
          style "top" "-15px" -- Score place at 30px from bottom
        , style "color" "rgb(30,144,255)" -- Score
        , style "font-family" "Helvetica, Arial, sans-serif"
        , style "font-size" "18px"
        , style "font-weight" "20000" -- Thickness of text
        , style "left" "0px" -- Score place at 30px from left/right
        , style "line-height" "60px"
        , style "position" "absolute" -- Score Need
        ]
        [ text ("Score: " ++ toString model.scoreboard.player_score) ]


viewLife : Int -> Html Msg
viewLife x =
    div
        [ style "top" "0px" -- Score place at 30px from bottom
        , style "left" "200px" -- Score place at 30px from left/right
        , style "position" "absolute" -- Score Need
        ]
        [ Svg.svg
            [ SvgAttr.width "100%"
            , SvgAttr.height "100%"
            ]
            [ Svg.circle
                [ SvgAttr.cx (toString x ++ "%")
                , SvgAttr.cy "8%"
                , SvgAttr.r "7"
                , SvgAttr.fill "blue"
                , SvgAttr.stroke "black"
                , SvgAttr.strokeWidth "2"
                ]
                []
            ]
        ]


viewLives : Model -> List (Html Msg)
viewLives model =
    List.range 1 model.scoreboard.player_lives
        |> List.map (\x -> x * 10)
        |> List.map viewLife


view : Model -> Html Msg
view model =
    div
        [ HtmlAttr.style "width" "100%"
        , HtmlAttr.style "height" "100%"
        , HtmlAttr.style "position" "fixed"
        , HtmlAttr.style "left" "0"
        , HtmlAttr.style "top" "0"
        ]
        ([ Svg.svg
            [ SvgAttr.width "100%"
            , SvgAttr.height "100%"
            ]
            -- draw bricks
            (List.map viewBricks model.list_brick
                ++ -- draw paddle
                   Svg.rect
                    [ SvgAttr.width (toString model.paddle.width ++ "%")
                    , SvgAttr.height (toString model.paddle.height ++ "%")
                    , SvgAttr.x (toString (Tuple.first model.paddle.pos) ++ "%")
                    , SvgAttr.y (toString (Tuple.second model.paddle.pos) ++ "%")
                    , SvgAttr.fill "rgb(30,144,255)"
                    ]
                    []
                :: -- draw ball
                   [ Svg.circle
                        [ SvgAttr.cx (toString (Tuple.first model.ball.pos) ++ "%")
                        , SvgAttr.cy (toString (Tuple.second model.ball.pos) ++ "%")
                        , SvgAttr.r (toString model.ball.radius ++ "%")
                        , SvgAttr.fill "rgb(0,0,128)"
                        ]
                        []
                   ]
            )
         , viewScore model
         ]
            ++ viewLives model
        )



----------
-- KEY/SUB
----------


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.batch
        [ onAnimationFrameDelta Tick
        , onKeyDown (Decode.map key keyCode)
        ]


key : Int -> Msg
key keycode =
    case keycode of
        37 ->
            Key Left

        39 ->
            Key Right

        _ ->
            Key_None
