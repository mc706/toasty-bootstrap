module Toasty.Defaults
    exposing
        ( Toast(..)
        , config
        , view
        )

{-| This module provides a generic toast type with four variants (info, success, error and warning)
each one supports a title and optional secondary message.

**You need to load the provided `Defaults.css` file in your project**. `bounceInRight`
and `fadeOutRightBig` animations borrowed from [Animate.css](https://daneden.github.io/animate.css/)
project by Daniel Eden.

See a [demo](http://pablen-toasty-demo.surge.sh/).


# Definition

@docs Toast, config, view

-}

import Bootstrap.Alert as Alert
import Html exposing (..)
import Html.Attributes exposing (..)
import Toasty


{-| This theme defines toasts of four variants: "Info", "Success", "Warning" and "Error".
Each of them accepts a title and an optional secondary message.
-}
type Toast
    = Info String String
    | Success String String
    | Warning String String
    | Error String String


{-| Default theme configuration.
-}
config : Toasty.Config msg
config =
    Toasty.config
        |> Toasty.transitionOutDuration 700
        |> Toasty.transitionOutAttrs transitionOutAttrs
        |> Toasty.transitionInAttrs transitionInAttrs
        |> Toasty.containerAttrs containerAttrs
        |> Toasty.itemAttrs itemAttrs
        |> Toasty.delay 5000


containerAttrs : List (Html.Attribute msg)
containerAttrs =
    [ style
        [ ( "position", "fixed" )
        , ( "top", "0" )
        , ( "right", "0" )
        , ( "width", "100%" )
        , ( "max-width", "300px" )
        , ( "list-style-type", "none" )
        , ( "padding", "0" )
        , ( "margin", "0" )
        ]
    ]


itemAttrs : List (Html.Attribute msg)
itemAttrs =
    [ style
        [ ( "margin", "1em 1em 0 1em" )
        , ( "max-height", "100px" )
        , ( "transition", "max-height 0.6s, margin-top 0.6s" )
        ]
    ]


transitionInAttrs : List (Html.Attribute msg)
transitionInAttrs =
    [ class "animated bounceInRight"
    ]


transitionOutAttrs : List (Html.Attribute msg)
transitionOutAttrs =
    [ class "animated fadeOutRightBig"
    , style
        [ ( "max-height", "0" )
        , ( "margin-top", "0" )
        ]
    ]


{-| Default theme view handling the three toast variants.
-}
view : Toast -> Html msg
view toast =
    case toast of
        Info title message ->
            simpleAlert Alert.simpleInfo title message

        Success title message ->
            simpleAlert Alert.simpleSuccess title message

        Warning title message ->
            simpleAlert Alert.simpleWarning title message

        Error title message ->
            simpleAlert Alert.simpleDanger title message


simpleAlert : (List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg) -> String -> String -> Html msg
simpleAlert config title message =
    div
        [ class "toasty-container" ]
        [ config
            []
            [ Alert.h5 [] [ text title ]
            , text message
            ]
        ]
