module App exposing (main)

import Html exposing (div, text, i, p, text)
import Browser

initialState =
    {
        count = 0
    }



render state =
    let
        renderCount = text (String.fromInt state.count)
    in
        div [] [
            p [][
                renderCount
            ]
        ]

reducer action state = state

main =  Browser.sandbox
    {
        init = initialState,
        view = render,
        update = reducer
    }