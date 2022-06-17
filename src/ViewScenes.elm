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
sceneWidth =
    2135.231317


sceneHeight : Float
sceneHeight =
    1200


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
    ( 761.9107343, toFloat (250 + 75 * line) )


matchScene : Int -> Model -> List (Html Msg)
matchScene n model =
    case n of
        3 ->
            [ helperScene1 "white" model.time 1 "General!! The monsters have penetrated into our defences!" ( 761.9107343, 325 ) 35
            , helperScene1 "white" model.time 2 "Gameplay: Boss monster changes element randomly" ( 761.9107343, 400 ) 35
            , helperScene1 "white" model.time 3 "Monsters are moving down" ( 761.9107343, 475 ) 35
            , helperScene1 "white" model.time 4 "2 lives will be deducted when monsters are too low." ( 761.9107343, 550 ) 35
            , helperScene1 "white" model.time 5 "See you on the other side General!" ( 761.9107343, 625 ) 35
            , helperScene1 "white" model.time 6 "Click S during the game to skip the level and SPACE to fire" ( 761.9107343, 850 ) 35
            , helperScene1 "white" model.time 7 "Click Enter to continue" ( 761.9107343, 925 ) 35
            ]

        4 ->
            [ helperScene1 "white" model.time 1 "General!! There is another wave of monsters attacking!" ( 761.9107343, 325 ) 35
            , helperScene1 "white" model.time 2 "Gameplay: Water>Fire>Nature>Earth>Water" ( 761.9107343, 400 ) 35
            , helperScene1 "white" model.time 3 "Monsters will move down even faster" ( 761.9107343, 475 ) 35
            , helperScene1 "white" model.time 4 "Higher scores awarded for more effective kills" ( 761.9107343, 650 ) 35
            , helperScene1 "white" model.time 5 "General, you are our only hope to save Zandalore!" ( 761.9107343, 750 ) 35
            , helperScene1 "white" model.time 6 "Click S during the game to skip the level and SPACE to fire" ( 761.9107343, 850 ) 35
            , helperScene1 "white" model.time 7 "Click Enter to continue" ( 761.9107343, 925 ) 35
            ]

        5 ->
            [ helperScene1 "white" model.time 1 "General!! The monsters seem like they are retreating!" ( 761.9107343, 325 ) 35
            , helperScene1 "white" model.time 2 "Gameplay: 2 balls present" ( 761.9107343, 400 ) 35
            , helperScene1 "white" model.time 3 "Choose when you want to launch ball with SPACE" ( 761.9107343, 475 ) 35
            , helperScene1 "white" model.time 4 "Monsters will be moving around" ( 761.9107343, 650 ) 35
            , helperScene1 "white" model.time 5 "Do not be complacent, the war isn't over yet!" ( 761.9107343, 750 ) 35
            , helperScene1 "white" model.time 6 "Click S during the game to skip the level and SPACE to fire" ( 761.9107343, 850 ) 35
            , helperScene1 "white" model.time 7 "Click Enter to continue" ( 761.9107343, 925 ) 35
            ]

        6 ->
            [ helperScene1 "white" model.time 1 "Bad news!! The elemental boss monster is attacking us!" ( 761.9107343, 325 ) 35
            , helperScene1 "white" model.time 2 "Gameplay: defeat the boss!" ( 761.9107343, 400 ) 35
            , helperScene1 "white" model.time 3 "Boss will spawn smaller elemental monsters" ( 761.9107343, 475 ) 35
            , helperScene1 "white" model.time 4 "Remember, strategy is key to winning." ( 761.9107343, 650 ) 35
            , helperScene1 "white" model.time 5 "General, this is your last chance to exterminate them!" ( 761.9107343, 750 ) 35
            , helperScene1 "white" model.time 6 "Click S during the game to skip the level and SPACE to fire" ( 761.9107343, 850 ) 35
            , helperScene1 "white" model.time 7 "Click Enter to continue" ( 761.9107343, 925 ) 35
            ]

        _ ->
            [ helperScene1 "dodgerblue" model.time 1 "Zandalore has won the war and defeated the vicious elemental monsters!" ( 700, 325 ) 35
            , helperScene1 "dodgerblue" model.time 2 "Undeniably, destroying the monsters was no easy feat. " ( 700, 400 ) 35
            , helperScene1 "dodgerblue" model.time 3 "General, I thank you for accomplishing this key mission." ( 700, 475 ) 35
            , helperScene1 "dodgerblue" model.time 4 "You have saved the world and justice has prevailed!" ( 700, 650 ) 35
            , helperScene1 "white" model.time 5 "You have completed Boss Level!" ( 700, 750 ) 35
            , helperScene1 "white" model.time 6 "Click Enter to go back to the Homepage" ( 700, 925 ) 35
            ]
logoWidth : Float
logoWidth = 523.2558

logoHeight : Float
logoHeight = 600


determineOpct : Float -> Float
determineOpct t =
    if (t <= 6) then
        (sin (t * pi / 6)) * 2 / 1.732
    else 
        0

viewScene0 : Model -> Html Msg
viewScene0 model =
    let
        ( w, h ) =
            model.size
        t = model.time
        r =
            if w / h > logoWidth / logoHeight then
                Basics.min 1 (h / logoHeight)

            else
                Basics.min 1 (w / logoWidth)
        
    in
    
    div
        [HtmlAttr.style "width" (String.fromFloat logoWidth ++ "px")
        , HtmlAttr.style "height" (String.fromFloat logoHeight ++ "px")
        , HtmlAttr.style "position" "absolute"
        , HtmlAttr.style "left" (String.fromFloat ((w - logoWidth * r) / 2) ++ "px")
        , HtmlAttr.style "top" (String.fromFloat ((h - logoHeight * r) / 2) ++ "px")
        , HtmlAttr.style "opacity" ((determineOpct t) |> String.fromFloat)
        , HtmlAttr.style "transform-origin" "0 0"
        , HtmlAttr.style "transform" ("scale(" ++ String.fromFloat r ++ ")")
        , HtmlAttr.style "background" ("url('./assets/image/ace.png')" ++ " no-repeat fixed " ++ " 0px " ++ " 0px / " ++ ( " 523.2558px " ) ++ ( " 600px"))
        ]
        []

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
        [ HtmlAttr.style "width" (String.fromFloat sceneWidth ++ "px")
        , HtmlAttr.style "height" (String.fromFloat sceneHeight ++ "px")
        , HtmlAttr.style "position" "absolute"
        , HtmlAttr.style "left" (String.fromFloat ((w - sceneWidth * r) / 2) ++ "px")
        , HtmlAttr.style "top" (String.fromFloat ((h - sceneHeight * r) / 2) ++ "px")
        , HtmlAttr.style "transform-origin" "0 0"
        , HtmlAttr.style "transform" ("scale(" ++ String.fromFloat r ++ ")")
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
        [ helperScene1 "white" model.time 1 "Gameplay: Water is more effective against fire" ( 761.9107343, 325 ) 35
        , helperScene1 "white" model.time 2 "There are 2 different monsters: fire and water monster." ( 761.9107343, 450 ) 35
        , helperScene1 "white" model.time 3 "Boss elemental monster functions as a border here." ( 761.9107343, 525 ) 35
        , helperScene1 "white" model.time 4 "Bullet changes element after coming in contact with monster." ( 761.9107343, 600 ) 35
        , helperScene1 "white" model.time 5 "Water bullets deal more damage against fire monsters." ( 761.9107343, 675 ) 35
        , helperScene1 "white" model.time 6 "All the best General! Destroy the evil elemental monsters!" ( 761.9107343, 750 ) 35
        , helperScene1 "white" model.time 7 "Click S during the game to skip the level and SPACE to fire" ( 761.9107343, 850 ) 35
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
