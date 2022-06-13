module ViewPlaying exposing (..)

{- This file contains all the helper functions needed in the major game states -}

import Bounce exposing (..)
import Color exposing (..)
import Debug exposing (toString)
import Html exposing (..)
import Html.Attributes as HtmlAttr exposing (..)
import Html.Events exposing (onClick)
import Messages exposing (..)
import Model exposing (..)
import Paddle exposing (..)
import Svg exposing (Svg)
import Svg.Attributes as SvgAttr


viewPaddle : Model -> Svg Msg
viewPaddle model =
    Svg.image
        [ SvgAttr.width (toString model.paddle.width)
        , SvgAttr.height (toString model.paddle.height)
        , SvgAttr.x (toString (Tuple.first model.paddle.pos))
        , SvgAttr.y (toString (Tuple.second model.paddle.pos))
        , SvgAttr.preserveAspectRatio "xMidYMid slice"
        , SvgAttr.xlinkHref "../assets/ufo.png"
        ]
        []


viewBall : Model -> Svg Msg
viewBall model =
    Svg.circle
        [ SvgAttr.cx (toString (Tuple.first model.ball1.pos))
        , SvgAttr.cy (toString (Tuple.second model.ball1.pos))
        , SvgAttr.r (toString model.ball1.radius)
        , SvgAttr.fill (getcolor (getColorful model.time))
        ]
        []


viewBricks : Brick -> Svg Msg
viewBricks brick =
    let
        ( row, col ) =
            brick.pos
    in
    -- add if condition of bricks existence later
    Svg.image
        [ SvgAttr.width (toString brickwidth)
        , SvgAttr.height (toString brickheight)
        , SvgAttr.x (toString (toFloat (col - 1) * brickwidth))
        , SvgAttr.y (toString (toFloat (row - 1) * brickheight + 50))
        , SvgAttr.preserveAspectRatio "none"
        , SvgAttr.xlinkHref "../assets/monster1.png"
        ]
        []


viewScore : Model -> Html Msg
viewScore model =
    div
        [ style "top" "-15px"
        , style "color" (getcolor (getColorful model.time))
        , style "font-family" "Helvetica, Arial, sans-serif"
        , style "font-size" "60px"
        , style "font-weight" "bold" -- Thickness of text
        , style "left" "467px"
        , style "text-align" "center"
        , style "top" "10px"
        , style "line-height" "60px"
        , style "position" "absolute"

        -- , style "color" (toString (getcolor (getColorful model.time)))
        ]
        [ text (toString model.scoreboard.player_score) ]


viewLife : Model -> Int -> Svg Msg
viewLife model x =
    -- draw cities using rectangles later
    Svg.image
        [ SvgAttr.width "180"
        , SvgAttr.height "100"
        , SvgAttr.x (toString x)
        , SvgAttr.y "1070"
        , SvgAttr.preserveAspectRatio "xMidYMid"
        , SvgAttr.xlinkHref "../assets/city.png"
        ]
        []


viewLives : Model -> List (Svg Msg)
viewLives model =
    List.range 1 model.scoreboard.player_lives
        |> List.map (\x -> (x - 1) * 205)
        |> List.map (viewLife model)


viewBase : Model -> Svg Msg
viewBase model =
    Svg.rect
        [ SvgAttr.fill (getcolor (getColorful model.time))
        , SvgAttr.width (toString pixelWidth)
        , SvgAttr.height "30"
        , SvgAttr.y "1170"
        , SvgAttr.x "0"
        ]
        []



----------
--HELPER FUNCTIONS
----------


newGameButton : Html Msg
newGameButton =
    button
        [ style "background" "#34495f"
        , style "border" "0"
        , style "bottom" "300px"
        , style "color" "#fff"
        , style "cursor" "pointer"
        , style "display" "block"
        , style "font-family" "Helvetica, Arial, sans-serif"
        , style "font-size" "18px"
        , style "font-weight" "300"
        , style "height" "60px"
        , style "left" "440px"
        , style "line-height" "60px"
        , style "outline" "none"
        , style "padding" "0"
        , style "position" "absolute"
        , style "width" "120px"
        , onClick Start
        ]
        [ text "New Game" ]


renderButton : String -> Html Msg
renderButton words =
    button
        [ style "background" "#34495f"
        , style "border" "0"
        , style "bottom" "300px" -- to be changed
        , style "left" "440px" -- to be changed
        , style "color" "#fff"
        , style "cursor" "pointer"
        , style "display" "block"
        , style "font-family" "Helvetica, Arial, sans-serif"
        , style "font-size" "18px"
        , style "font-weight" "300"
        , style "height" "60px"
        , style "line-height" "60px"
        , style "outline" "none"
        , style "padding" "0"
        , style "position" "absolute"
        , style "width" "120px"
        , onClick Start
        ]
        [ text words ]
