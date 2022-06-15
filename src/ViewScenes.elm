module ViewScenes exposing (..)

{- This file contains all the scenes for the game -}

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


viewScene11 : Model -> Html Msg
viewScene11 model =
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
        [ helperScene11 "dodgerblue" model.time 1 "Zandalore, the only space colony that has mastered immortality," ( 100, 100 )
        , helperScene11 "dodgerblue" model.time 2 "has been living in peace for the past few centuries." ( 100, 180 )
        , helperScene11 "dodgerblue" model.time 3 "But one day, the elemental monsters attack Zandalore" ( 100, 260 )
        , helperScene11 "dodgerblue" model.time 4 "to steal the secret to immortality." ( 100, 340 )
        , helperScene11 "dodgerblue" model.time 5 "General, you are our only hope to save Zandalore!" ( 100, 420 )
        , helperScene11 "white" model.time 6 "Click Enter to continue" ( 100, 500 )
        ]


helperScene11 : String -> Float -> Float -> String -> ( Float, Float ) -> Html Msg
helperScene11 color modeltime time string ( x, y ) =
    div
        [ HtmlAttr.style "opacity" (toString (modeltime - time))
        , HtmlAttr.style "left" (toString x ++ "px")
        , HtmlAttr.style "top" (toString y ++ "px")
        , style "font-weight" "bold"
        , HtmlAttr.style "color" color
        , HtmlAttr.style "position" "absolute"
        , HtmlAttr.style "font-size" (toString 30 ++ "px")
        ]
        [ text string ]
