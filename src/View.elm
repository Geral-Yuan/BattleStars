module View exposing (..)

{- This file contains the view function for all the major game states -}
-- import Html.Events exposing (onClick)

import Bounce exposing (..)
import Color exposing (..)
import Data exposing (..)
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
import ViewScenes exposing (..)


view : Model -> Html Msg
view model =
    let
        viewAll =
            case model.state of
                Starting ->
                    viewStarting model

                Playing _ ->
                    viewPlaying model
                Scene 0 ->
                    viewScene0 model
                Scene 1 ->
                    viewScene1 model

                Scene 2 ->
                    viewScene2 model

                Scene a ->
                    viewOtherScene a model

                ClearLevel _ ->
                    viewClearLevel model

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
        ]
startWidth : Float
startWidth = pixelHeight

startHeight : Float
startHeight = pixelHeight

viewStarting : Model -> Html Msg
viewStarting model =
    let
        ( w, h ) =
            model.size

        r =
            if w / h > startWidth / startHeight then
                Basics.min 1 (h / startHeight)

            else
                Basics.min 1 (w / startWidth)
    in
    div
        [ HtmlAttr.style "width" (String.fromFloat startWidth ++ "px")
        , HtmlAttr.style "height" (String.fromFloat startHeight ++ "px")
        , HtmlAttr.style "position" "absolute"
        , HtmlAttr.style "left" (String.fromFloat (((w - startWidth * r) / 2) ) ++ "px")
        , HtmlAttr.style "top" (String.fromFloat ((h - startHeight * r) / 2) ++ "px")
        , HtmlAttr.style "transform-origin" "0 0"
        , HtmlAttr.style "transform" ("scale(" ++ String.fromFloat r ++ ")")
        , HtmlAttr.style "background" ("url('./assets/image/Start.png')"  ++ " no-repeat fixed " ++ " 0px " ++ " 0px / " ++ (toString startWidth ++ "px " ++ (toString startHeight ++ "px")))
        --, HtmlAttr.style "background-attachment" "fixed"
        --, HtmlAttr.style "outline" "medium white solid"
        ]
        [ renderStartButton
        , div
            [ HtmlAttr.style "left" "-200px"
            , HtmlAttr.style "top" "0px"
            ]
            [ Html.audio
                [ HtmlAttr.autoplay True
                , HtmlAttr.loop True
                , HtmlAttr.src "./assets/audio/Start.ogg"
                , HtmlAttr.preload "True"
                , HtmlAttr.id "start"
                , HtmlAttr.controls True
                ]
                []
            ]
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
        , HtmlAttr.style "background" ("url('./assets/image/background.png')")
        --, HtmlAttr.style "outline" "medium white solid"
        ]
        [ 
            -- div [ HtmlAttr.style "z-index" "99999999" ]
            -- [ Html.audio
            --     [ HtmlAttr.autoplay True
            --     , HtmlAttr.loop True
            --     , HtmlAttr.controls True
            --     , HtmlAttr.src "./assets/audio/gamePlay.ogg"
            --     , HtmlAttr.preload "True"
            --     , HtmlAttr.id "game"
            --     ]
            --     []
            -- ]
         Svg.svg
            [ SvgAttr.width "100%"
            , SvgAttr.height "100%"
            ]
            -- draw monsters
            ([ viewBase model

             -- , viewLife model
             ]
                ++ viewLives model
                ++ List.map viewMonsters model.monster_list
                ++ (List.concat (List.map viewCover model.monster_list))
                ++ (List.concat(List.map viewBall (List.reverse model.ball_list)))             
                ++ viewBoss model.boss
                ++ viewBossCover model.boss
                ++ [ viewPaddle model]
            )
        , viewScore model
        ]
clearWidth : Float
clearWidth = 6400/3

cleatHeight : Float
cleatHeight = 1200
viewClearLevel : Model -> Html Msg
viewClearLevel model =
    let
        ( w, h ) =
            model.size

        r =
            if w / h > clearWidth / cleatHeight then
                Basics.min 1 (h / cleatHeight)

            else
                Basics.min 1 (w / clearWidth)
    in
    div
        [ HtmlAttr.style "width" (String.fromFloat (clearWidth) ++ "px")
        , HtmlAttr.style "height" (String.fromFloat cleatHeight ++ "px")
        , HtmlAttr.style "position" "absolute"

        , HtmlAttr.style "left" (String.fromFloat ((w - clearWidth * r) / 2) ++ "px")
        , HtmlAttr.style "top" (String.fromFloat ((h - cleatHeight * r) / 2) ++ "px")
        , HtmlAttr.style "transform-origin" "0 0"
        , HtmlAttr.style "transform" ("scale(" ++ String.fromFloat r ++ ")")
        , HtmlAttr.style "background" "url('./assets/image/background.png')"
        ]
        [ nextSceneButton
        , helperScene1 (getcolor (getColorful model.time)) model.time 1 "MISSION ACCOMPLISHED" ( 6400 * (2490-1385) /6 /2490, 300 ) 100
        , helperScene1 (getcolor (getColorful model.time)) model.time 1 ("Level " ++ toString model.level ++ " cleared") (  6400 * (2490-883) /6 /2490, 450 ) 100
        , helperScene1 (getcolor (getColorful model.time)) model.time 2 ("Score: " ++ toString model.scores) (  6400 * (2490-700) /6 /2490, 600 ) 100
        ]


viewGameover : Model -> Html Msg
viewGameover model =
    let
        ( w, h ) =
            model.size

        r =
            if w / h > clearWidth / cleatHeight then
                Basics.min 1 (h / cleatHeight)

            else
                Basics.min 1 (w / clearWidth)
    in
    div
        [ HtmlAttr.style "width" (String.fromFloat (clearWidth) ++ "px")
        , HtmlAttr.style "height" (String.fromFloat cleatHeight ++ "px")
        , HtmlAttr.style "position" "absolute"
        , HtmlAttr.style "left" (String.fromFloat ((w - clearWidth * r) / 2) ++ "px")
        , HtmlAttr.style "top" (String.fromFloat ((h - cleatHeight * r) / 2) ++ "px")
        , HtmlAttr.style "transform-origin" "0 0"
        , HtmlAttr.style "transform" ("scale(" ++ String.fromFloat r ++ ")")
        , HtmlAttr.style "background" "url('./assets/image/background.png')"
        ]
        [ newGameButton
        , helperScene1 (getcolor (getColorful model.time)) model.time 1 "MISSION FAILED" (  649.7978 , 450 ) 100
        ]
