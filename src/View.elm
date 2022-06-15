module View exposing (..)

{- This file contains the view function for all the major game states -}
-- import Html.Events exposing (onClick)

import Bounce exposing (..)
import Color exposing (..)
import Data exposing (..)
import Debug exposing (toString)
import Html exposing (..)
import Html.Attributes as HtmlAttr exposing (..)
import Messages exposing (..)
import Model exposing (..)
import Paddle exposing (..)
import Svg exposing (Svg)
import Svg.Attributes as SvgAttr
import ViewPlaying exposing (..)
import ViewScenes exposing (..)


view : Model -> Html Msg
view model =
    let
        viewAll =
            case model.state of
                Starting ->
                    viewStarting model

                Playing1 ->
                    viewPlaying1 model

                Playing2 ->
                    viewPlaying1 model

                Playing3 ->
                    viewPlaying1 model

                Playing4 ->
                    viewPlaying1 model

                Playing5 ->
                    viewPlaying1 model

                Scene11 ->
                    viewScene11 model

                Scene12 ->
                    viewScene11 model

                Scene2 ->
                    viewScene11 model

                Scene3 ->
                    viewScene11 model

                Scene4 ->
                    viewScene11 model

                Scene5 ->
                    viewScene11 model

                Victory ->
                    viewGameover model

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
        , HtmlAttr.style "background" "url('../assets/Start.png')"
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
            []
        ]


viewPlaying1 : Model -> Html Msg
viewPlaying1 model =
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
            -- draw monsters
            ([ viewBase model

             -- , viewLife model
             ]
                ++ viewLives model
                ++ List.map viewMonsters model.monster_list
                ++ List.map viewCover model.monster_list
                ++ List.map viewBall model.ball_list
                ++ -- draw paddle
                   [ viewPaddle model ]
            )
        , viewScore model
        ]


viewPlaying2 : Model -> Html Msg
viewPlaying2 model =
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
            -- draw monsters
            ([ viewBase model

             -- , viewLife model
             ]
                ++ viewLives model
                ++ List.map viewMonsters model.monster_list
                ++ List.map viewCover model.monster_list
                ++ List.map viewBall model.ball_list
                ++ -- draw paddle
                   [ viewPaddle model ]
            )
        , viewScore model
        ]


viewPlaying3 : Model -> Html Msg
viewPlaying3 model =
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
            -- draw monsters
            ([ viewBase model

             -- , viewLife model
             ]
                ++ viewLives model
                ++ List.map viewMonsters model.monster_list
                ++ List.map viewCover model.monster_list
                ++ List.map viewBall model.ball_list
                ++ -- draw paddle
                   [ viewPaddle model ]
            )
        , viewScore model
        ]


viewPlaying4 : Model -> Html Msg
viewPlaying4 model =
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
            -- draw monsters
            ([ viewBase model

             -- , viewLife model
             ]
                ++ viewLives model
                ++ List.map viewMonsters model.monster_list
                ++ List.map viewCover model.monster_list
                ++ List.map viewBall model.ball_list
                ++ -- draw paddle
                   [ viewPaddle model ]
            )
        , viewScore model
        ]


viewPlaying5 : Model -> Html Msg
viewPlaying5 model =
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
            -- draw monsters
            ([ viewBase model

             -- , viewLife model
             ]
                ++ viewLives model
                ++ List.map viewMonsters model.monster_list
                ++ List.map viewCover model.monster_list
                ++ List.map viewBall model.ball_list
                ++ -- draw paddle
                   [ viewPaddle model ]
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
            -- draw monsters
            ([ viewBase model

             -- , viewLife model
             ]
                ++ viewLives model
                ++ List.map viewMonsters model.monster_list
                ++ List.map viewCover model.monster_list
                ++ List.map viewBall model.ball_list
                ++ -- draw paddle
                   [ viewPaddle model ]
            )
        , viewScore model
        , newGameButton
        ]
