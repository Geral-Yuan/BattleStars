module M1 exposing (..)

import Html exposing (..)
import Html.Attributes as HtmlAttr exposing (..)
import Svg exposing (Svg)
import Svg.Attributes as SvgAttr



--Main


main : Html msg
main =
    div
        [ HtmlAttr.style "width" "100%"
        , HtmlAttr.style "height" "100%"
        , HtmlAttr.style "position" "fixed"
        , HtmlAttr.style "left" "0"
        , HtmlAttr.style "top" "0"
        ]
        [ Svg.svg
            [ SvgAttr.width "100%"
            , SvgAttr.height "100%"
            ]
            [ Svg.rect
                [ SvgAttr.x "0px"
                , SvgAttr.y "0px"
                , SvgAttr.width "50px"
                , SvgAttr.height "20px"
                , SvgAttr.rx "5px"
                , SvgAttr.ry "5px"
                , SvgAttr.fill "black"
                ]
                []
            , Svg.rect
                [ SvgAttr.x "0px"
                , SvgAttr.y "20px"
                , SvgAttr.width "50px"
                , SvgAttr.height "20px"
                , SvgAttr.rx "5px"
                , SvgAttr.ry "5px"
                , SvgAttr.fill "blue"
                ]
                []
            , Svg.rect
                [ SvgAttr.x "50px"
                , SvgAttr.y "0px"
                , SvgAttr.width "50px"
                , SvgAttr.height "20px"
                , SvgAttr.rx "5px"
                , SvgAttr.ry "5px"
                , SvgAttr.fill "blue"
                ]
                []
            , Svg.rect
                [ SvgAttr.x "50px"
                , SvgAttr.y "20px"
                , SvgAttr.width "50px"
                , SvgAttr.height "20px"
                , SvgAttr.rx "5px"
                , SvgAttr.ry "5px"
                , SvgAttr.fill "black"
                ]
                []
            , Svg.rect
                [ SvgAttr.x "100px"
                , SvgAttr.y "0px"
                , SvgAttr.width "50px"
                , SvgAttr.height "20px"
                , SvgAttr.rx "5px"
                , SvgAttr.ry "5px"
                , SvgAttr.fill "black"
                ]
                []
            , Svg.rect
                [ SvgAttr.x "100px"
                , SvgAttr.y "20px"
                , SvgAttr.width "50px"
                , SvgAttr.height "20px"
                , SvgAttr.rx "5px"
                , SvgAttr.ry "5px"
                , SvgAttr.fill "blue"
                ]
                []
            , Svg.rect
                [ SvgAttr.x "150px"
                , SvgAttr.y "0px"
                , SvgAttr.width "50px"
                , SvgAttr.height "20px"
                , SvgAttr.rx "5px"
                , SvgAttr.ry "5px"
                , SvgAttr.fill "blue"
                ]
                []
            , Svg.rect
                [ SvgAttr.x "150px"
                , SvgAttr.y "20px"
                , SvgAttr.width "50px"
                , SvgAttr.height "20px"
                , SvgAttr.rx "5px"
                , SvgAttr.ry "5px"
                , SvgAttr.fill "black"
                ]
                []
            , Svg.rect
                [ SvgAttr.x "200px"
                , SvgAttr.y "0px"
                , SvgAttr.width "50px"
                , SvgAttr.height "20px"
                , SvgAttr.rx "5px"
                , SvgAttr.ry "5px"
                , SvgAttr.fill "black"
                ]
                []
            , Svg.rect
                [ SvgAttr.x "200px"
                , SvgAttr.y "20px"
                , SvgAttr.width "50px"
                , SvgAttr.height "20px"
                , SvgAttr.rx "5px"
                , SvgAttr.ry "5px"
                , SvgAttr.fill "blue"
                ]
                []
            , Svg.rect
                [ SvgAttr.x "250px"
                , SvgAttr.y "0px"
                , SvgAttr.width "50px"
                , SvgAttr.height "20px"
                , SvgAttr.rx "5px"
                , SvgAttr.ry "5px"
                , SvgAttr.fill "black"
                ]
                []
            , Svg.rect
                [ SvgAttr.x "250px"
                , SvgAttr.y "20px"
                , SvgAttr.width "50px"
                , SvgAttr.height "20px"
                , SvgAttr.rx "5px"
                , SvgAttr.ry "5px"
                , SvgAttr.fill "blue"
                ]
                []
            , Svg.rect
                [ SvgAttr.x "300px"
                , SvgAttr.y "0px"
                , SvgAttr.width "50px"
                , SvgAttr.height "20px"
                , SvgAttr.rx "5px"
                , SvgAttr.ry "5px"
                , SvgAttr.fill "blue"
                ]
                []
            , Svg.rect
                [ SvgAttr.x "300px"
                , SvgAttr.y "20px"
                , SvgAttr.width "50px"
                , SvgAttr.height "20px"
                , SvgAttr.rx "5px"
                , SvgAttr.ry "5px"
                , SvgAttr.fill "black"
                ]
                []
            , Svg.rect
                [ SvgAttr.x "350px"
                , SvgAttr.y "0px"
                , SvgAttr.width "50px"
                , SvgAttr.height "20px"
                , SvgAttr.rx "5px"
                , SvgAttr.ry "5px"
                , SvgAttr.fill "black"
                ]
                []
            , Svg.rect
                [ SvgAttr.x "350px"
                , SvgAttr.y "20px"
                , SvgAttr.width "50px"
                , SvgAttr.height "20px"
                , SvgAttr.rx "5px"
                , SvgAttr.ry "5px"
                , SvgAttr.fill "blue"
                ]
                []
            , Svg.rect
                [ SvgAttr.x "400px"
                , SvgAttr.y "0px"
                , SvgAttr.width "50px"
                , SvgAttr.height "20px"
                , SvgAttr.rx "5px"
                , SvgAttr.ry "5px"
                , SvgAttr.fill "blue"
                ]
                []
            , Svg.rect
                [ SvgAttr.x "400px"
                , SvgAttr.y "20px"
                , SvgAttr.width "50px"
                , SvgAttr.height "20px"
                , SvgAttr.rx "5px"
                , SvgAttr.ry "5px"
                , SvgAttr.fill "black"
                ]
                []
            , Svg.rect
                [ SvgAttr.x "450px"
                , SvgAttr.y "0px"
                , SvgAttr.width "50px"
                , SvgAttr.height "20px"
                , SvgAttr.rx "5px"
                , SvgAttr.ry "5px"
                , SvgAttr.fill "black"
                ]
                []
            , Svg.rect
                [ SvgAttr.x "450px"
                , SvgAttr.y "20px"
                , SvgAttr.width "50px"
                , SvgAttr.height "20px"
                , SvgAttr.rx "5px"
                , SvgAttr.ry "5px"
                , SvgAttr.fill "blue"
                ]
                []
            , Svg.rect
                [ SvgAttr.x "200px"
                , SvgAttr.y "200px"
                , SvgAttr.width "100px"
                , SvgAttr.height "5px"
                , SvgAttr.rx "5px"
                , SvgAttr.ry "5px"
                , SvgAttr.fill "blue"
                ]
                []
            , Svg.circle
                [ SvgAttr.cx "250px"
                , SvgAttr.cy "190px"
                , SvgAttr.r "5px"
                , SvgAttr.fill "black"
                ]
                []
            ]
        ]
