module ViewScenes exposing (..)

{- This file contains all the scenes for the game -}

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


viewScene1 : Model -> Html Msg
viewScene1 model =
    div
        [ HtmlAttr.style "width" (toString pixelWidth ++ "px")
        , HtmlAttr.style "height" (toString pixelHeight ++ "px")
        , HtmlAttr.style "position" "absolute"
        , HtmlAttr.style "left" (toString (pixelWidth / 2 - 350) ++ "px")
        , HtmlAttr.style "top" "0px"

        -- , HtmlAttr.style "margin" (toString (Tuple.second model.size / 2 - (600 * model.new_size) / 2) ++ "px " ++ toString (Tuple.first model.size / 2 - (700 * model.new_size) / 2) ++ "px")
        --, HtmlAttr.style "margin" "10px 300px 10px"
        -- , HtmlAttr.style "overflow" "hidden"
        ]
        [ helperScene1 "dodgerblue" model.time 1 "Zandalore, the only space colony that has mastered immortality," ( 100, 100 ) 30
        , helperScene1 "dodgerblue" model.time 2 "has been living in peace for the past few centuries." ( 100, 180 ) 30
        , helperScene1 "dodgerblue" model.time 3 "But one day, the elemental monsters attack Zandalore" ( 100, 260 ) 30
        , helperScene1 "dodgerblue" model.time 4 "and kill millions of Zandalorians to steal the secret to immortality." ( 100, 340 ) 30
        , helperScene1 "dodgerblue" model.time 5 "General, you are our only hope to save Zandalore!" ( 100, 420 ) 30
        , helperScene1 "white" model.time 6 "Click Enter to continue" ( 100, 500 ) 30
        , div [ HtmlAttr.style "z-index" "99999999" ]
            [ Html.audio
                [ HtmlAttr.autoplay True
                , HtmlAttr.loop True
                , HtmlAttr.controls True
                , HtmlAttr.src "./assets/audio/Start.ogg"
                , HtmlAttr.preload "True"
                , HtmlAttr.id "start"
                ]
                []
            ]
        ]


viewScene2 : Model -> Html Msg
viewScene2 model =
    div
        [ HtmlAttr.style "width" (toString pixelWidth ++ "px")
        , HtmlAttr.style "height" (toString pixelHeight ++ "px")
        , HtmlAttr.style "position" "absolute"
        , HtmlAttr.style "left" (toString (1000 / 2 - 350) ++ "px")
        , HtmlAttr.style "top" "0px"
        , HtmlAttr.style "background" ("url('./assets/image/scene.png')" ++ " no-repeat fixed " ++ " 0px " ++ " 0px / " ++ "1050px " ++ " 550px")

        -- , HtmlAttr.style "margin" (toString (Tuple.second model.size / 2 - (600 * model.new_size) / 2) ++ "px " ++ toString (Tuple.first model.size / 2 - (700 * model.new_size) / 2) ++ "px")
        --, HtmlAttr.style "margin" "10px 300px 10px"
        -- , HtmlAttr.style "overflow" "hidden"
        ]
        [ helperScene1 "white" model.time 1 "Zandalore, the only space colony that has mastered immortality," ( 350, 150 ) 22
        , helperScene1 "white" model.time 2 "has been living in peace for the past few centuries." ( 350, 180 ) 22
        , helperScene1 "white" model.time 3 "But one day, the elemental monsters attack Zandalore" ( 350, 260 ) 22
        , helperScene1 "white" model.time 4 "to steal the secret to immortality." ( 350, 340 ) 22
        , helperScene1 "white" model.time 5 "General, you are our only hope to save Zandalore!" ( 350, 420 ) 22
        , helperScene1 "white" model.time 6 "Click Enter to continue" ( 350, 450 ) 22
        , div [ HtmlAttr.style "z-index" "99999999" ]
            [ Html.audio
                [ HtmlAttr.autoplay True
                , HtmlAttr.loop True
                , HtmlAttr.controls True
                , HtmlAttr.src "./assets/audio/Start.ogg"
                , HtmlAttr.preload "True"
                , HtmlAttr.id "start"
                ]
                []
            ]
        ]


viewScene3 : Model -> Html Msg
viewScene3 model =
    div
        [ HtmlAttr.style "width" (toString pixelWidth ++ "px")
        , HtmlAttr.style "height" (toString pixelHeight ++ "px")
        , HtmlAttr.style "position" "absolute"
        , HtmlAttr.style "left" (toString (1000 / 2 - 350) ++ "px")
        , HtmlAttr.style "top" "0px"
        , HtmlAttr.style "background" ("url('./assets/image/scene.png')" ++ " no-repeat fixed " ++ " 0px " ++ " 0px / " ++ "1050px " ++ " 550px")

        -- , HtmlAttr.style "margin" (toString (Tuple.second model.size / 2 - (600 * model.new_size) / 2) ++ "px " ++ toString (Tuple.first model.size / 2 - (700 * model.new_size) / 2) ++ "px")
        --, HtmlAttr.style "margin" "10px 300px 10px"
        -- , HtmlAttr.style "overflow" "hidden"
        ]
        [ helperScene1 "white" model.time 1 "Zandalore, the only space colony that has mastered immortality," ( 350, 150 ) 22
        , helperScene1 "white" model.time 2 "has been living in peace for the past few centuries." ( 350, 180 ) 22
        , helperScene1 "white" model.time 3 "But one day, the elemental monsters attack Zandalore" ( 350, 260 ) 22
        , helperScene1 "white" model.time 4 "to steal the secret to immortality." ( 350, 340 ) 22
        , helperScene1 "white" model.time 5 "General, you are our only hope to save Zandalore!" ( 350, 420 ) 22
        , helperScene1 "white" model.time 6 "Click Enter to continue" ( 350, 450 ) 22
        , div [ HtmlAttr.style "z-index" "99999999" ]
            [ Html.audio
                [ HtmlAttr.autoplay True
                , HtmlAttr.loop True
                , HtmlAttr.controls True
                , HtmlAttr.src "./assets/audio/Start.ogg"
                , HtmlAttr.preload "True"
                , HtmlAttr.id "start"
                ]
                []
            ]
        ]


viewScene4 : Model -> Html Msg
viewScene4 model =
    div
        [ HtmlAttr.style "width" (toString pixelWidth ++ "px")
        , HtmlAttr.style "height" (toString pixelHeight ++ "px")
        , HtmlAttr.style "position" "absolute"
        , HtmlAttr.style "left" (toString (pixelWidth / 2 - 350) ++ "px")
        , HtmlAttr.style "top" "0px"
        , HtmlAttr.style "background" ("url('./assets/image/scene.png')" ++ " no-repeat fixed " ++ " 0px " ++ " 0px / " ++ "1050px " ++ " 550px")

        -- , HtmlAttr.style "margin" (toString (Tuple.second model.size / 2 - (600 * model.new_size) / 2) ++ "px " ++ toString (Tuple.first model.size / 2 - (700 * model.new_size) / 2) ++ "px")
        --, HtmlAttr.style "margin" "10px 300px 10px"
        -- , HtmlAttr.style "overflow" "hidden"
        ]
        [ helperScene1 "white" model.time 1 "Zandalore, the only space colony that has mastered immortality," ( 350, 150 ) 22
        , helperScene1 "white" model.time 2 "has been living in peace for the past few centuries." ( 350, 180 ) 22
        , helperScene1 "white" model.time 3 "But one day, the elemental monsters attack Zandalore" ( 350, 260 ) 22
        , helperScene1 "white" model.time 4 "to steal the secret to immortality." ( 350, 340 ) 22
        , helperScene1 "white" model.time 5 "General, you are our only hope to save Zandalore!" ( 350, 420 ) 22
        , helperScene1 "white" model.time 6 "Click Enter to continue" ( 350, 450 ) 22
        , div [ HtmlAttr.style "z-index" "99999999" ]
            [ Html.audio
                [ HtmlAttr.autoplay True
                , HtmlAttr.loop True
                , HtmlAttr.controls True
                , HtmlAttr.src "./assets/audio/Start.ogg"
                , HtmlAttr.preload "True"
                , HtmlAttr.id "start"
                ]
                []
            ]
        ]


viewScene5 : Model -> Html Msg
viewScene5 model =
    div
        [ HtmlAttr.style "width" (toString pixelWidth ++ "px")
        , HtmlAttr.style "height" (toString pixelHeight ++ "px")
        , HtmlAttr.style "position" "absolute"
        , HtmlAttr.style "left" (toString (pixelWidth / 2 - 350) ++ "px")
        , HtmlAttr.style "top" "0px"
        , HtmlAttr.style "background" ("url('./assets/image/scene.png')" ++ " no-repeat fixed " ++ " 0px " ++ " 0px / " ++ "1050px " ++ " 550px")

        -- , HtmlAttr.style "margin" (toString (Tuple.second model.size / 2 - (600 * model.new_size) / 2) ++ "px " ++ toString (Tuple.first model.size / 2 - (700 * model.new_size) / 2) ++ "px")
        --, HtmlAttr.style "margin" "10px 300px 10px"
        -- , HtmlAttr.style "overflow" "hidden"
        ]
        [ helperScene1 "white" model.time 1 "Zandalore, the only space colony that has mastered immortality," ( 350, 150 ) 22
        , helperScene1 "white" model.time 2 "has been living in peace for the past few centuries." ( 350, 180 ) 22
        , helperScene1 "white" model.time 3 "But one day, the elemental monsters attack Zandalore" ( 350, 260 ) 22
        , helperScene1 "white" model.time 4 "to steal the secret to immortality." ( 350, 340 ) 22
        , helperScene1 "white" model.time 5 "General, you are our only hope to save Zandalore!" ( 350, 420 ) 22
        , helperScene1 "white" model.time 6 "Click Enter to continue" ( 350, 450 ) 22
        , div [ HtmlAttr.style "z-index" "99999999" ]
            [ Html.audio
                [ HtmlAttr.autoplay True
                , HtmlAttr.loop True
                , HtmlAttr.controls True
                , HtmlAttr.src "./assets/audio/Start.ogg"
                , HtmlAttr.preload "True"
                , HtmlAttr.id "start"
                ]
                []
            ]
        ]


viewScene6 : Model -> Html Msg
viewScene6 model =
    div
        [ HtmlAttr.style "width" (toString pixelWidth ++ "px")
        , HtmlAttr.style "height" (toString pixelHeight ++ "px")
        , HtmlAttr.style "position" "absolute"
        , HtmlAttr.style "left" (toString (pixelWidth / 2 - 350) ++ "px")
        , HtmlAttr.style "top" "0px"
        , HtmlAttr.style "background" ("url('./assets/image/scene.png')" ++ " no-repeat fixed " ++ " 0px " ++ " 0px / " ++ "1050px " ++ " 550px")

        -- , HtmlAttr.style "margin" (toString (Tuple.second model.size / 2 - (600 * model.new_size) / 2) ++ "px " ++ toString (Tuple.first model.size / 2 - (700 * model.new_size) / 2) ++ "px")
        --, HtmlAttr.style "margin" "10px 300px 10px"
        -- , HtmlAttr.style "overflow" "hidden"
        ]
        [ helperScene1 "white" model.time 1 "Zandalore, the only space colony that has mastered immortality," ( 350, 150 ) 22
        , helperScene1 "white" model.time 2 "has been living in peace for the past few centuries." ( 350, 180 ) 22
        , helperScene1 "white" model.time 3 "But one day, the elemental monsters attack Zandalore" ( 350, 260 ) 22
        , helperScene1 "white" model.time 4 "to steal the secret to immortality." ( 350, 340 ) 22
        , helperScene1 "white" model.time 5 "General, you are our only hope to save Zandalore!" ( 350, 420 ) 22
        , helperScene1 "white" model.time 6 "Click Enter to continue" ( 350, 450 ) 22
        , div [ HtmlAttr.style "z-index" "99999999" ]
            [ Html.audio
                [ HtmlAttr.autoplay True
                , HtmlAttr.loop True
                , HtmlAttr.controls True
                , HtmlAttr.src "./assets/audio/Start.ogg"
                , HtmlAttr.preload "True"
                , HtmlAttr.id "start"
                ]
                []
            ]
        ]


viewScene7 : Model -> Html Msg
viewScene7 model =
    div
        [ HtmlAttr.style "width" (toString pixelWidth ++ "px")
        , HtmlAttr.style "height" (toString pixelHeight ++ "px")
        , HtmlAttr.style "position" "absolute"
        , HtmlAttr.style "left" (toString (pixelWidth / 2 - 350) ++ "px")
        , HtmlAttr.style "top" "0px"
        , HtmlAttr.style "background" ("url('./assets/image/scene.png')" ++ " no-repeat fixed " ++ " 0px " ++ " 0px / " ++ "1050px " ++ " 550px")

        -- , HtmlAttr.style "margin" (toString (Tuple.second model.size / 2 - (600 * model.new_size) / 2) ++ "px " ++ toString (Tuple.first model.size / 2 - (700 * model.new_size) / 2) ++ "px")
        --, HtmlAttr.style "margin" "10px 300px 10px"
        -- , HtmlAttr.style "overflow" "hidden"
        ]
        [ helperScene1 "white" model.time 1 "Zandalore, the only space colony that has mastered immortality," ( 350, 150 ) 22
        , helperScene1 "white" model.time 2 "has been living in peace for the past few centuries." ( 350, 180 ) 22
        , helperScene1 "white" model.time 3 "But one day, the elemental monsters attack Zandalore" ( 350, 260 ) 22
        , helperScene1 "white" model.time 4 "to steal the secret to immortality." ( 350, 340 ) 22
        , helperScene1 "white" model.time 5 "General, you are our only hope to save Zandalore!" ( 350, 420 ) 22
        , helperScene1 "white" model.time 6 "Click Enter to continue" ( 350, 450 ) 22
        , div [ HtmlAttr.style "z-index" "99999999" ]
            [ Html.audio
                [ HtmlAttr.autoplay True
                , HtmlAttr.loop True
                , HtmlAttr.controls True
                , HtmlAttr.src "./assets/audio/Start.ogg"
                , HtmlAttr.preload "True"
                , HtmlAttr.id "start"
                ]
                []
            ]
        ]


helperScene1 : String -> Float -> Float -> String -> ( Float, Float ) -> Int -> Html Msg
helperScene1 color modeltime time string ( x, y ) font =
    div
        [ HtmlAttr.style "opacity" (toString (modeltime - time))
        , HtmlAttr.style "left" (toString x ++ "px")
        , HtmlAttr.style "top" (toString y ++ "px")
        , style "font-weight" "bold"
        , HtmlAttr.style "color" color
        , HtmlAttr.style "position" "absolute"
        , HtmlAttr.style "font-size" (toString font ++ "px")
        ]
        [ text string ]
