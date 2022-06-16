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
                    viewPlaying1 model

                Scene 1 ->
                    viewScene1 model

                Scene 2 ->
                    viewScene2 model

                Scene 3 ->
                    viewScene3 model

                Scene 4 ->
                    viewScene4 model

                Scene 5 ->
                    viewScene5 model

                Scene 6 ->
                    viewScene6 model

                Scene _ ->
                    -- Last Scene to congratulate players
                    viewScene7 model

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
            [ HtmlAttr.style "left" "-200px"
            , HtmlAttr.style "top" "0px"
            ]
            [ Html.audio
                [ HtmlAttr.autoplay True
                , HtmlAttr.loop True
                , HtmlAttr.src "../assets/Music/Start.ogg"
                , HtmlAttr.preload "True"
                , HtmlAttr.id "start"
                , HtmlAttr.controls True
                ]
                []
            ]
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
        [ div [ HtmlAttr.style "z-index" "99999999" ]
            [ Html.audio
                [ HtmlAttr.autoplay True
                , HtmlAttr.loop True
                , HtmlAttr.controls True
                , HtmlAttr.src "../assets/Music/gamePlay.ogg"
                , HtmlAttr.preload "True"
                , HtmlAttr.id "game"
                ]
                []
            ]
        , Svg.svg
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


viewClearLevel : Model -> Html Msg
viewClearLevel model =
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
        [ HtmlAttr.style "width" (String.fromFloat (pixelWidth + 2000) ++ "px")
        , HtmlAttr.style "height" (String.fromFloat pixelHeight ++ "px")
        , HtmlAttr.style "position" "absolute"

        -- , HtmlAttr.style "left" (String.fromFloat ((w - pixelWidth * r) / 2) ++ "px")
        -- , HtmlAttr.style "top" (String.fromFloat ((h - pixelHeight * r) / 2) ++ "px")
        , HtmlAttr.style "transform-origin" "0 0"
        , HtmlAttr.style "transform" ("scale(" ++ String.fromFloat r ++ ")")
        , HtmlAttr.style "background" "url('../assets/background.png')"
        , HtmlAttr.style "outline" "medium white solid"
        ]
        [ nextSceneButton
        , helperScene1 (getcolor (getColorful model.time)) model.time 1 "MISSION ACCOMPLISHED" ( 690, 450 ) 100
        , helperScene1 (getcolor (getColorful model.time)) model.time 1 ("Level " ++ toString model.level ++ " cleared") ( 1010, 550 ) 100
        , helperScene1 (getcolor (getColorful model.time)) model.time 2 ("Score: " ++ toString model.scores) ( 1150, 650 ) 100
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
        [ HtmlAttr.style "width" (String.fromFloat (pixelWidth + 2000) ++ "px")
        , HtmlAttr.style "height" (String.fromFloat pixelHeight ++ "px")
        , HtmlAttr.style "position" "absolute"

        -- , HtmlAttr.style "left" (String.fromFloat ((w - pixelWidth * r) / 2) ++ "px")
        -- , HtmlAttr.style "top" (String.fromFloat ((h - pixelHeight * r) / 2) ++ "px")
        , HtmlAttr.style "transform-origin" "0 0"
        , HtmlAttr.style "transform" ("scale(" ++ String.fromFloat r ++ ")")
        , HtmlAttr.style "background" "url('../assets/background.png')"
        , HtmlAttr.style "outline" "medium white solid"
        ]
        [ newGameButton
        , helperScene1 (getcolor (getColorful model.time)) model.time 1 "MISSION FAILED" ( 920, 450 ) 100
        ]
