port module App exposing (main)

import Html exposing (Html, p, text, button)
import Html.Events exposing (onClick)
import Browser

type alias State = {input: String, output: String}

view state = p [][text "hello"]

init : () -> (State, Cmd msg)
init _ =
    (
        {
            input = "",
            output = ""
        },
        Cmd.none
    )

update action state = state

subscriptions state = Sub.none

main = Browser.element {
        init = init,
        update = update,
        view = view,
        subscriptions = subscriptions
    }