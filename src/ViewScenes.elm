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

sceneWidth : Float
sceneWidth = 2135.231317 
sceneHeight : Float
sceneHeight = 1200
viewOtherScene : Int -> Model -> Html Msg
viewOtherScene n model =
    let
        ( w, h ) =
            model.size

        r =
            if w / h > sceneWidth / sceneHeight then
                Basics.min 1 (h / sceneHeight)

            else
                Basics.min 1 (w / sceneWidth)
        htmlMsg =
            matchScene n model
    in
    
     div
        [ HtmlAttr.style "width" (String.fromFloat sceneWidth ++ "px")
        , HtmlAttr.style "height" (String.fromFloat sceneHeight ++ "px")
        , HtmlAttr.style "position" "absolute"
        , HtmlAttr.style "left" (String.fromFloat ((w - sceneWidth * r) / 2) ++ "px")
        , HtmlAttr.style "top" (String.fromFloat ((h - sceneHeight * r) / 2) ++ "px")
        , HtmlAttr.style "transform-origin" "0 0"
        , HtmlAttr.style "transform" ("scale(" ++ String.fromFloat r ++ ")")
        , HtmlAttr.style "background" ("url('./assets/image/scene.png')" ++ " no-repeat fixed " ++ " 0px " ++ " 0px / " ++ "2135.231317px " ++ " 1200px")
        ]
        htmlMsg
getLinePos : Int -> ( Float, Float )
getLinePos line =
    ( 761.9107343, toFloat (250 + 75 * line))

matchScene : Int -> Model -> List (Html Msg)
matchScene n model =
    case n of
        3 ->
            [ helperScene1 "white" model.time 1 "Zandalore, the only space colony that has mastered immortality," ( 761.9107343, 325 ) 35
            , helperScene1 "white" model.time 2 "has been living in peace for the past few centuries." ( 761.9107343, 400 ) 35
            , helperScene1 "white" model.time 3 "But one day, the elemental monsters attack Zandalore" ( 761.9107343, 475 ) 35
            , helperScene1 "white" model.time 4 "to steal the secret to immortality." ( 761.9107343, 650 ) 35
            , helperScene1 "white" model.time 5 "General, you are our only hope to save Zandalore!" ( 761.9107343, 750 ) 35
            , helperScene1 "white" model.time 6 "Click S during the game to skip the level" ( 761.9107343, 850 ) 35
            , helperScene1 "white" model.time 7 "Click Enter to continue" ( 761.9107343, 925 ) 35
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

        4 ->
            [ helperScene1 "white" model.time 1 "Zandalore, the only space colony that has mastered immortality," ( 761.9107343, 325  ) 35 
            , helperScene1 "white" model.time 2 "has been living in peace for the past few centuries." ( 761.9107343, 180 ) 35 
            , helperScene1 "white" model.time 3 "But one day, the elemental monsters attack Zandalore" ( 761.9107343, 260 ) 35 
            , helperScene1 "white" model.time 4 "to steal the secret to immortality." ( 761.9107343, 340 ) 35 
            , helperScene1 "white" model.time 5 "General, you are our only hope to save Zandalore!" ( 761.9107343, 420 ) 35 
            , helperScene1 "white" model.time 6 "Click S during the game to skip the level" ( 761.9107343, 450 ) 35 
            , helperScene1 "white" model.time 6 "Click Enter to continue" ( 761.9107343, 450 ) 35 
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

        5 ->
            [ helperScene1 "white" model.time 1 "Zandalore, the only space colony that has mastered immortality," ( 761.9107343, 320 ) 35 
            , helperScene1 "white" model.time 2 "has been living in peace for the past few centuries." ( 761.9107343, 180 ) 35 
            , helperScene1 "white" model.time 3 "But one day, the elemental monsters attack Zandalore" ( 761.9107343, 260 ) 35 
            , helperScene1 "white" model.time 4 "to steal the secret to immortality." ( 761.9107343, 340 ) 35 
            , helperScene1 "white" model.time 5 "General, you are our only hope to save Zandalore!" ( 761.9107343, 420 ) 35 
            , helperScene1 "white" model.time 6 "Click Enter to continue" ( 761.9107343, 450 ) 35 
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

        6 ->
            [ helperScene1 "white" model.time 1 "Zandalore, the only space colony that has mastered immortality," ( 761.9107343, 325  ) 35 
            , helperScene1 "white" model.time 2 "has been living in peace for the past few centuries." ( 761.9107343, 180 ) 35 
            , helperScene1 "white" model.time 3 "But one day, the elemental monsters attack Zandalore" ( 761.9107343, 260 ) 35 
            , helperScene1 "white" model.time 4 "to steal the secret to immortality." ( 761.9107343, 340 ) 35 
            , helperScene1 "white" model.time 5 "General, you are our only hope to save Zandalore!" ( 761.9107343, 420 ) 35 
            , helperScene1 "white" model.time 6 "Click Enter to continue" ( 761.9107343, 450 ) 35 
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

        _ ->
            [ helperScene1 "dodgerblue" model.time 1 "Zandalore has won the war and defeated the vicious Aliens!" ( 761.9107343, 325  ) 35 
            , helperScene1 "dodgerblue" model.time 2 "Undeniably, destroying the aliens was no easy feat. " ( 761.9107343, 180 ) 35 
            , helperScene1 "dodgerblue" model.time 3 "General, I thank you for accomplishing this key mission." ( 761.9107343, 260 ) 35 
            , helperScene1 "dodgerblue" model.time 4 "You have saved the world and justice has prevailed!" ( 761.9107343, 340 ) 35 
            , helperScene1 "white" model.time 5 "You have completed Boss Level" ( 761.9107343, 420 ) 35 
            , helperScene1 "white" model.time 6 "Click Enter to go back to the Homepage" ( 761.9107343, 450 ) 35 
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


viewScene1 : Model -> Html Msg
viewScene1 model =
    let
        ( w, h ) =
            model.size

        r =
            if w / h > sceneWidth / sceneHeight then
                Basics.min 1 (h / sceneHeight)

            else
                Basics.min 1 (w / sceneWidth)
        
    in
    
    div
        [HtmlAttr.style "width" (String.fromFloat sceneWidth ++ "px")
        , HtmlAttr.style "height" (String.fromFloat sceneHeight ++ "px")
        , HtmlAttr.style "position" "absolute"
        , HtmlAttr.style "left" (String.fromFloat ((w - sceneWidth * r) / 2) ++ "px")
        , HtmlAttr.style "top" (String.fromFloat ((h - sceneHeight * r) / 2) ++ "px")
        , HtmlAttr.style "transform-origin" "0 0"
        , HtmlAttr.style "transform" ("scale(" ++ String.fromFloat r ++ ")")
        , HtmlAttr.style "background" ("url('./assets/image/scene.png')" ++ " no-repeat fixed " ++ " 0px " ++ " 0px / " ++ (String.fromFloat sceneHeight ++ "px") ++ (String.fromFloat sceneWidth ++ "px"))
        

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
    let
        ( w, h ) =
            model.size

        r =
            if w / h > sceneWidth / sceneHeight then
                Basics.min 1 (h / sceneHeight)

            else
                Basics.min 1 (w / sceneWidth)
        
    in
    div
        [ HtmlAttr.style "width" (String.fromFloat sceneWidth ++ "px")
        , HtmlAttr.style "height" (String.fromFloat sceneHeight ++ "px")
        , HtmlAttr.style "position" "absolute"
        , HtmlAttr.style "left" (String.fromFloat ((w - sceneWidth * r) / 2) ++ "px")
        , HtmlAttr.style "top" (String.fromFloat ((h - sceneHeight * r) / 2) ++ "px")
        , HtmlAttr.style "transform-origin" "0 0"
        , HtmlAttr.style "transform" ("scale(" ++ String.fromFloat r ++ ")")
        , HtmlAttr.style "background" ("url('./assets/image/scene.png')" ++ " no-repeat fixed " ++ " 0px " ++ " 0px / " ++ "2135.231317px " ++ " 1200px")

        ]
        [ helperScene1 "white" model.time 1 "Zandalore, the only space colony that has mastered immortality," ( 761.9107343, 325  ) 35 
        , helperScene1 "white" model.time 2 "has been living in peace for the past few centuries." ( 761.9107343, 180 ) 35 
        , helperScene1 "white" model.time 3 "But one day, the elemental monsters attack Zandalore" ( 761.9107343, 260 ) 35 
        , helperScene1 "white" model.time 4 "to steal the secret to immortality." ( 761.9107343, 340 ) 35 
        , helperScene1 "white" model.time 5 "General, you are our only hope to save Zandalore!" ( 761.9107343, 420 ) 35 
        , helperScene1 "white" model.time 6 "Click Enter to continue" ( 761.9107343, 450 ) 35 
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

