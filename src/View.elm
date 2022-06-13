module View exposing (..)

{- This file contains the view function for all the major game states -}

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
import ViewPlaying exposing (..)


view : Model -> Html Msg
view model =
    let
        viewAll =
            case model.state of
                Playing ->
                    viewPlaying model

                Starting ->
                    viewStarting model

                Gameover ->
                    viewGameover model
    in
    div
        [ HtmlAttr.style "width" "100%"
        , HtmlAttr.style "height" "100%"
        , HtmlAttr.style "position" "fixed"
        , HtmlAttr.style "left" "0"
        , HtmlAttr.style "top" "0"
        , HtmlAttr.style "background" "black"
        ]
        [ viewAll

        {- add audio controls here -}
        ]


viewStarting : Model -> Html Msg
viewStarting model =
    let
        ( w, h ) =
            model.size

        r =
            if w / h > pixelWidth / pixelHeight then
                Basics.min 1 (h / pixelHeight)

            else
                Basics.min 1 (w / pixelWidth)
    in
    div
        [ HtmlAttr.style "width" (String.fromFloat pixelWidth ++ "px")
        , HtmlAttr.style "height" (String.fromFloat pixelHeight ++ "px")
        , HtmlAttr.style "position" "absolute"
        , HtmlAttr.style "left" (String.fromFloat ((w - pixelWidth * r) / 2) ++ "px")
        , HtmlAttr.style "top" (String.fromFloat ((h - pixelHeight * r) / 2) ++ "px")
        , HtmlAttr.style "transform-origin" "0 0"
        , HtmlAttr.style "transform" ("scale(" ++ String.fromFloat r ++ ")")
        , HtmlAttr.style "background" "black"
        , HtmlAttr.style "outline" "medium white solid"
        ]
        [ renderButton "Start"
        , div
            [ style "width" (toString (pixelWidth / 4) ++ "px")
            , style "height" (toString (pixelHeight / 4) ++ "px")
            , style "position" "fixed"
            , style "left" (toString (pixelWidth / 4) ++ "px")
            , style "top" (toString (pixelHeight / 4) ++ "px")
            , style "color" "white"
            , style "font-family" "Helvetica, Arial, sans-serif"
            , style "font-size" "120px"
            , style "font-weight" "bold"
            ]
            [ text "COSMIC\nWARRIORS" ]
        ]


viewPlaying : Model -> Html Msg
viewPlaying model =
    let
        ( w, h ) =
            model.size

        r =
            if w / h > pixelWidth / pixelHeight then
                Basics.min 1 (h / pixelHeight)

            else
                Basics.min 1 (w / pixelWidth)
    in
    div
        [ HtmlAttr.style "width" (String.fromFloat pixelWidth ++ "px")
        , HtmlAttr.style "height" (String.fromFloat pixelHeight ++ "px")
        , HtmlAttr.style "position" "absolute"
        , HtmlAttr.style "left" (String.fromFloat ((w - pixelWidth * r) / 2) ++ "px")
        , HtmlAttr.style "top" (String.fromFloat ((h - pixelHeight * r) / 2) ++ "px")
        , HtmlAttr.style "transform-origin" "0 0"
        , HtmlAttr.style "transform" ("scale(" ++ String.fromFloat r ++ ")")
        , HtmlAttr.style "background" "url('../assets/background.png')"
        , HtmlAttr.style "outline" "medium white solid"
        ]
        [ Svg.svg
            [ SvgAttr.width "100%"
            , SvgAttr.height "100%"
            ]
            -- draw bricks
            ([ viewBase model

             -- , viewLife model
             ]
                ++ viewLives model
                ++ List.map viewBricks model.list_brick
                ++ -- draw paddle
                   [ viewPaddle model
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


viewGameover : Model -> Html Msg
viewGameover model =
    let
        ( w, h ) =
            model.size

        r =
            if w / h > pixelWidth / pixelHeight then
                Basics.min 1 (h / pixelHeight)

            else
                Basics.min 1 (w / pixelWidth)
    in
    div
        [ HtmlAttr.style "width" (String.fromFloat pixelWidth ++ "px")
        , HtmlAttr.style "height" (String.fromFloat pixelHeight ++ "px")
        , HtmlAttr.style "position" "absolute"
        , HtmlAttr.style "left" (String.fromFloat ((w - pixelWidth * r) / 2) ++ "px")
        , HtmlAttr.style "top" (String.fromFloat ((h - pixelHeight * r) / 2) ++ "px")
        , HtmlAttr.style "transform-origin" "0 0"
        , HtmlAttr.style "transform" ("scale(" ++ String.fromFloat r ++ ")")
        , HtmlAttr.style "background" "url('../assets/background.png')"
        , HtmlAttr.style "outline" "medium white solid"
        ]
        [ Svg.svg
            [ SvgAttr.width "100%"
            , SvgAttr.height "100%"
            ]
            -- draw bricks
            ([ viewBase model
             ]
                ++ viewLives model
                ++ List.map viewBricks model.list_brick
                ++ -- draw paddle
                   [ viewPaddle model
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
