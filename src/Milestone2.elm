module Milestone2 exposing (..)

import Browser
import Browser.Events exposing (onAnimationFrameDelta, onKeyDown)
import Debug exposing (toString)
import Html exposing (..)
import Html.Attributes as HtmlAttr exposing (..)
import Html.Events exposing (keyCode)
import Json.Decode as Decode
import String exposing (left)
import Svg exposing (Svg)
import Svg.Attributes as SvgAttr


type alias Scoreboard =
    { player_score : Int
    , player_lives : Int
    }


type Dir
    = Left
    | Right
    | Still --Still added because we are updating with Tick


type alias Brick =
    { pos : ( Float, Float )
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
    , theta : Float
    , speed : Float
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
    , ball = Ball ( 50, 50 ) 1.5 (pi / 4) 0.3 --initial theta = pi/4; --initial speed = 1, adjust it if too fast or slow!!
    , time = 0
    , scoreboard = initScoreboard 3 --three lives for a player
    }


initScoreboard : Int -> Scoreboard
initScoreboard lives =
    Scoreboard 0 lives


initBrick : ( Float, Float ) -> Int -> Int -> List Brick
initBrick ( row, col ) lives score =
    if row == 1 then
        initBrickRow ( row, col ) lives score

    else
        initBrickRow ( row, col ) lives score ++ initBrick ( row - 1, col ) lives score


initBrickRow : ( Float, Float ) -> Int -> Int -> List Brick
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
    ( model
    , Cmd.none
    )
        --|> updateBrick msg
        |> updatePaddle msg
        |> updateBall msg


updatePaddle : Msg -> ( Model, Cmd Msg ) -> ( Model, Cmd Msg )
updatePaddle msg ( model, cmd ) =
    let
        prev_paddle =
            model.paddle

        prev_x =
            Tuple.first prev_paddle.pos

        prev_y =
            Tuple.second prev_paddle.pos

        new_model =
            updatePaddleDir model msg

        new_paddle =
            new_model.paddle

        new_dir =
            new_paddle.dir
    in
    case msg of
        Tick _ ->
            --There is a problem wtih this code because msg Dir nested within Tick
            case new_dir of
                Left ->
                    if prev_x < 0 then
                        ( model, Cmd.none )

                    else
                        ( { new_model | paddle = { new_paddle | pos = ( prev_x - 0.3, prev_y ) } }, Cmd.none )

                Right ->
                    if prev_x > 85 then
                        --condition to prevent paddle from moving out of boundary
                        ( model, Cmd.none )

                    else
                        ( { new_model | paddle = { new_paddle | pos = ( prev_x + 0.3, prev_y ) } }, Cmd.none )

                Still ->
                    ( { new_model | paddle = { new_paddle | pos = ( prev_x, prev_y ) } }, Cmd.none )

        _ ->
            ( new_model, Cmd.none )


updatePaddleDir : Model -> Msg -> Model
updatePaddleDir model msg =
    let
        prev_paddle =
            model.paddle
    in
    case msg of
        Key Left ->
            { model | paddle = { prev_paddle | dir = Left } }

        Key Right ->
            { model | paddle = { prev_paddle | dir = Right } }

        Key_None ->
            { model | paddle = { prev_paddle | dir = Still } }

        _ ->
            model



-- { model | paddle = { prev_paddle | dir = Still } }


updateBall : Msg -> ( Model, Cmd Msg ) -> ( Model, Cmd Msg )
updateBall msg ( model, cmd ) =
    let
        prev_ball =
            model.ball

        prev_x =
            Tuple.first prev_ball.pos

        prev_y =
            Tuple.second prev_ball.pos

        prev_theta =
            prev_ball.theta

        prev_speed =
            prev_ball.speed

        new_ball =
            { prev_ball | pos = ( prev_x + cos prev_theta * prev_speed, prev_y + sin prev_theta * prev_speed ) }

        new_model =
            checkBounce { model | ball = new_ball }
    in
    case msg of
        Tick _ ->
            ( new_model, cmd )

        _ ->
            ( new_model, cmd )


checkBounce : Model -> Model
checkBounce model =
    checkBouncePaddle model
        |> checkBounceScreen



-- |> checkBounceBrick


checkBouncePaddle : Model -> Model
checkBouncePaddle model =
    let
        ( x, y ) =
            model.ball.pos

        r =
            model.ball.radius
    in
    if y - r == Tuple.second model.paddle.pos then
        if x >= Tuple.first model.paddle.pos && x <= Tuple.first model.paddle.pos + model.paddle.width then
            let
                prev_ball =
                    model.ball

                prev_theta =
                    prev_ball.theta

                new_ball =
                    { prev_ball | theta = (2 * pi) - prev_theta }
            in
            { model | ball = new_ball }

        else
            model

    else
        model


checkBounceScreen : Model -> Model
checkBounceScreen model =
    let
        prev_ball =
            model.ball

        ( x, y ) =
            prev_ball.pos

        r =
            prev_ball.radius

        prev_theta =
            prev_ball.theta
    in
    if x + r >= 100 then
        { model | ball = { prev_ball | theta = pi - prev_theta } }

    else if x - r <= 0 then
        { model | ball = { prev_ball | theta = 3 * pi - prev_theta } }

    else if y - r <= 0 then
        { model | ball = { prev_ball | theta = 2 * pi - prev_theta } }

    else
        model



-- Previous updatePaddle without Tick for your reference
-- updatePaddle : Msg -> ( Model, Cmd Msg ) -> ( Model, Cmd Msg )
-- updatePaddle msg ( model, cmd ) =
--     case msg of
--         Key Left ->
--             let
--                 oldPaddle =
--                     model.paddle
--                 newPaddle =
--                     { oldPaddle
--                         | pos = paddlePos oldPaddle.pos Left
--                     }
--             in
--             ( { model | paddle = newPaddle }, cmd )
--         Key Right ->
--             let
--                 oldPaddle =
--                     model.paddle
--                 newPaddle =
--                     { oldPaddle
--                         | pos = paddlePos oldPaddle.pos Right
--                     }
--             in
--             ( { model | paddle = newPaddle }, cmd )
--         _ ->
--             ( model, cmd )
-- paddlePos : ( Float, Float ) -> Dir -> ( Float, Float )
-- paddlePos ( oldx, y ) dir =
--     case dir of
--         Left ->
--             if oldx - 8 < 0 then
--                 ( 0, y )
--             else
--                 ( oldx - 8, y )
--         Right ->
--             if oldx + 8 > 85 then
--                 ( 85, y )
--             else
--                 ( oldx + 8, y )
----------
-- VIEW
----------


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
        , SvgAttr.x (toString ((col - 1) * brickwidth) ++ "%")
        , SvgAttr.y (toString ((row - 1) * brickheight + 5) ++ "%")
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
