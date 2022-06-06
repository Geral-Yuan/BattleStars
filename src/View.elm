module View exposing (..)

import Svg.Attributes as SvgAttr
import Html.Attributes as HtmlAttr exposing (..)
import Html exposing (..)
import Debug exposing (toString)
import Svg exposing (Svg)
import Messages exposing (..)
import Model exposing (..)
import Paddle exposing (..)
import Bounce exposing (..)
import Color exposing (..)
viewBricks : Brick -> Svg msg
viewBricks brick =
    let
        ( row, col ) =
            brick.pos
    in
    -- add if condition of bricks existence later
    Svg.rect
        [ SvgAttr.width (toString brickwidth)
        , SvgAttr.height (toString brickheight)
        , SvgAttr.x (toString (toFloat(col - 1) * brickwidth))
        , SvgAttr.y (toString (toFloat(row - 1) * brickheight + 50))
        , SvgAttr.fill "rgb(104,91,209)"
        , SvgAttr.stroke "white"
        ]
        []


viewScore : Model -> Html Msg
viewScore model =
    div
        [ -- style "background" "#34495f"
          -- , style "border" "0"
          style "top" "-15px" -- Score place at 30px from bottom
        , style "color" "rgb(30,144,255)" -- Score
        , style "font-family" "Helvetica, Arial, sans-serif"
        , style "font-size" "18px"
        , style "font-weight" "20000" -- Thickness of text
        , style "left" "0px" -- Score place at 30px from left/right
        , style "line-height" "60px"
        , style "position" "absolute" -- Score Need
        ]
        [ text ("Score: " ++ toString model.scoreboard.player_score) ]


viewLife : Int -> Html Msg
viewLife x =
    div
        [ style "top" "0px" -- Score place at 30px from bottom
        , style "left" "200px" -- Score place at 30px from left/right
        , style "position" "absolute" -- Score Need
        ]
        [ Svg.svg
            [ SvgAttr.width "100%"
            , SvgAttr.height "100%"
            ]
            [ Svg.circle
                [ SvgAttr.cx (toString x ++ "%")
                , SvgAttr.cy "8%"
                , SvgAttr.r "7"
                , SvgAttr.fill "blue"
                , SvgAttr.stroke "black"
                , SvgAttr.strokeWidth "2"
                ]
                []
            ]
        ]


viewLives : Model -> List (Html Msg)
viewLives model =
    List.range 1 model.scoreboard.player_lives
        |> List.map (\x -> x * 10)
        |> List.map viewLife


view : Model -> Html Msg
view model =
    div
        [ HtmlAttr.style "width" "100%"
        , HtmlAttr.style "height" "100%"
        , HtmlAttr.style "position" "fixed"
        , HtmlAttr.style "left" "0"
        , HtmlAttr.style "top" "0"
        ]
        ([ Svg.svg
            [ SvgAttr.width "100%"
            , SvgAttr.height "100%"
            ]
            -- draw bricks
            (List.map viewBricks model.list_brick
                ++ -- draw paddle
                   Svg.rect
                    [ SvgAttr.width (toString model.paddle.width)
                    , SvgAttr.height (toString model.paddle.height)
                    , SvgAttr.x (toString ( Tuple.first (model.paddle.pos)))
                    , SvgAttr.y (toString (Tuple.second model.paddle.pos))
                    , SvgAttr.fill "rgb(30,144,255)"
                    ]
                    []
                :: -- draw ball
                   [ Svg.circle
                        [ SvgAttr.cx (toString (Tuple.first model.ball.pos))
                        , SvgAttr.cy (toString (Tuple.second model.ball.pos))
                        , SvgAttr.r (toString model.ball.radius)
                        , SvgAttr.fill (getcolor(getColorful model.time))
                        ]
                        []
                   ]
            )
         , viewScore model
         ]
            ++ viewLives model
        )
