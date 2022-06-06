module Main exposing (..)

import Browser
import Browser.Events exposing (onAnimationFrameDelta, onKeyDown, onKeyUp)
import Html.Events exposing (keyCode)
import Json.Decode as Decode

import Messages exposing (..)
import Model exposing (Model,init)
import Update exposing (..)
import View exposing (..)



main : Program () Model Msg
main =
    Browser.element { init = init, view = view, update = update, subscriptions = subscriptions }


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.batch
        [ 
        onAnimationFrameDelta Tick
        , onKeyUp (Decode.map (key False) keyCode)
        , onKeyDown (Decode.map (key True) keyCode)
        ]


key :Bool -> Int -> Msg
key on keycode =
    case keycode of
        37 ->
            Key Left on

        39 ->
            Key Right on

        _ ->
            Key_None
