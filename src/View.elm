module View exposing (..)

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


viewBricks : Brick -> Svg msg
viewBricks brick =
    let
        ( row, col ) =
            brick.pos
    in
    -- add if condition of bricks existence later
    Svg.rect
        [ SvgAttr.width (toString brickwidth)
        , SvgAttr.height (toString brickheight)
        , SvgAttr.x (toString (toFloat (col - 1) * brickwidth))
        , SvgAttr.y (toString (toFloat (row - 1) * brickheight + 50))
        , SvgAttr.fill "rgb(104,91,209)"
        , SvgAttr.stroke "white"
        ]
        []


viewScore : Model -> Html Msg
viewScore model =
    div
        [ style "top" "-15px"
        , style "color" "rgb(30,144,255)"
        , style "font-family" "Helvetica, Arial, sans-serif"
        , style "font-size" "18px"
        , style "font-weight" "20000" -- Thickness of text
        , style "left" "0px"
        , style "line-height" "60px"
        , style "position" "absolute"
        ]
        [ text ("Score: " ++ toString model.scoreboard.player_score) ]


viewLife : Model -> Int -> Html Msg
viewLife model x =
    div
        [ style "top" "0px"
        , style "left" "200px" -- Score place at 30px from left
        , style "position" "absolute"
        ]
        [ Svg.svg
            [ SvgAttr.width "100%"
            , SvgAttr.height "100%"
            ]
            [ Svg.circle
                [ SvgAttr.cx (toString x ++ "%")
                , SvgAttr.cy "8%"
                , SvgAttr.r "7"
                , SvgAttr.fill (getcolor (getColorful model.time))
                , SvgAttr.stroke "black"
                , SvgAttr.strokeWidth "1"
                ]
                []
            ]
        ]


viewLives : Model -> List (Html Msg)
viewLives model =
    List.range 1 model.scoreboard.player_lives
        |> List.map (\x -> x * 10)
        |> List.map (viewLife model)


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


view : Model -> Html Msg
view model =
    let
        ( w, h ) =
            model.size

        r =
            if w / h > pixelWidth / pixelHeight then
                Basics.min 1 (h / pixelHeight)

            else
                Basics.min 1 (w / pixelWidth)
    in
    if model.state == Gameover then
        
        div
            [ HtmlAttr.style "width" (String.fromFloat pixelWidth ++ "px")
            , HtmlAttr.style "height" (String.fromFloat pixelHeight ++ "px")
            , HtmlAttr.style "position" "absolute"
            , HtmlAttr.style "left" (String.fromFloat ((w - pixelWidth * r) / 2) ++ "px")
            , HtmlAttr.style "top" (String.fromFloat ((h - pixelHeight * r) / 2) ++ "px")
            , HtmlAttr.style "transform-origin" "0 0"
            , HtmlAttr.style "transform" ("scale(" ++ String.fromFloat r ++ ")")
            ]
            ([ Svg.svg
                [ SvgAttr.width "100%"
                , SvgAttr.height "100%"
                ]
                -- draw bricks
                (List.map viewBricks model.list_brick
                    ++ -- draw paddle
                       [ Svg.rect
                            [ SvgAttr.width (toString model.paddle.width)
                            , SvgAttr.height (toString model.paddle.height)
                            , SvgAttr.x (toString (Tuple.first model.paddle.pos))
                            , SvgAttr.y (toString (Tuple.second model.paddle.pos))
                            , SvgAttr.fill "rgb(30,144,255)"
                            ]
                            []
                       , -- draw ball 1
                         Svg.circle
                            [ SvgAttr.cx (toString (Tuple.first model.ball1.pos))
                            , SvgAttr.cy (toString (Tuple.second model.ball1.pos))
                            , SvgAttr.r (toString model.ball1.radius)
                            , SvgAttr.fill (getcolor (getColorful model.time))
                            ]
                            []
                       , -- draw ball 2
                         Svg.circle
                            [ SvgAttr.cx (toString (Tuple.first model.ball2.pos))
                            , SvgAttr.cy (toString (Tuple.second model.ball2.pos))
                            , SvgAttr.r (toString model.ball2.radius)
                            , SvgAttr.fill (getcolor (getColorful model.time))
                            ]
                            []
                       ]
                )
             , viewScore model
             , newGameButton
             ]
                ++ viewLives model
            )

    else
        div
            [ HtmlAttr.style "width" (String.fromFloat pixelWidth ++ "px")
            , HtmlAttr.style "height" (String.fromFloat pixelHeight ++ "px")
            , HtmlAttr.style "position" "absolute"
            , HtmlAttr.style "left" (String.fromFloat ((w - pixelWidth * r) / 2) ++ "px")
            , HtmlAttr.style "top" (String.fromFloat ((h - pixelHeight * r) / 2) ++ "px")
            , HtmlAttr.style "transform-origin" "0 0"
            , HtmlAttr.style "transform" ("scale(" ++ String.fromFloat r ++ ")")
            ]
            ([ Svg.svg
                [ SvgAttr.width "100%"
                , SvgAttr.height "100%"
                ]
                -- draw bricks
                (List.map viewBricks model.list_brick
                    ++ -- draw paddle
                       [ Svg.rect
                            [ SvgAttr.width (toString model.paddle.width)
                            , SvgAttr.height (toString model.paddle.height)
                            , SvgAttr.x (toString (Tuple.first model.paddle.pos))
                            , SvgAttr.y (toString (Tuple.second model.paddle.pos))
                            , SvgAttr.fill "rgb(30,144,255)"
                            ]
                            []
                       , -- draw ball 1
                         Svg.circle
                            [ SvgAttr.cx (toString (Tuple.first model.ball1.pos))
                            , SvgAttr.cy (toString (Tuple.second model.ball1.pos))
                            , SvgAttr.r (toString model.ball1.radius)
                            , SvgAttr.fill (getcolor (getColorful model.time))
                            ]
                            []
                       , -- draw ball 2
                         Svg.circle
                            [ SvgAttr.cx (toString (Tuple.first model.ball2.pos))
                            , SvgAttr.cy (toString (Tuple.second model.ball2.pos))
                            , SvgAttr.r (toString model.ball2.radius)
                            , SvgAttr.fill (getcolor (getColorful model.time))
                            ]
                            []
                       ]
                )
             , viewScore model
             ]
                ++ viewLives model
            )
