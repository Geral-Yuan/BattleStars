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

                Playing _ ->
                    viewPlaying1 model

                Scene 1 ->
                    viewScene1 model

                Scene 2 ->
                    viewScene1 model

                Scene 3 ->
                    viewScene1 model

                Scene 4 ->
                    viewScene1 model

                Scene 5 ->
                    viewScene1 model

                Scene 6 ->
                    viewScene1 model

                Scene _ ->
                    -- Last Scene to congratulate players
                    viewScene1 model

                ClearLevel _ ->
                    viewScene1 model

                Gameover _ ->
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
        [ HtmlAttr.style "width" "1200px"
        , HtmlAttr.style "height" (String.fromFloat pixelHeight ++ "px")
        , HtmlAttr.style "position" "absolute"
        , HtmlAttr.style "left" (String.fromFloat (((w - pixelWidth * r) / 2) - 50) ++ "px")
        , HtmlAttr.style "top" (String.fromFloat ((h - pixelHeight * r) / 2) ++ "px")
        , HtmlAttr.style "transform-origin" "0 0"
        , HtmlAttr.style "transform" ("scale(" ++ String.fromFloat r ++ ")")
        , HtmlAttr.style "background" ("url('../assets/Start.png')" ++ " no-repeat fixed " ++ " 0px " ++ " 0px / " ++ (toString 1200 ++ "px " ++ (toString 1200 ++ "px")))
        , HtmlAttr.style "background-attachment" "fixed"
        , HtmlAttr.style "outline" "medium white solid"
        ]
        [ renderStartButton
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
                ++ [ viewPaddle model, viewBoss model.boss, viewBossCover model.boss ]
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
            ([ viewBase model

             -- , viewLife model
             ]
                ++ viewLives model
                ++ List.map viewMonsters model.monster_list
                ++ List.map viewCover model.monster_list
                ++ List.map viewBall model.ball_list
                ++ [ viewPaddle model, viewBoss model.boss, viewBossCover model.boss ]
            )
        , viewScore model
        , newGameButton
        ]
