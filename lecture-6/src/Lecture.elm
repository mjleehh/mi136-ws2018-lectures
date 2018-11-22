module Lecture exposing (m)

import Browser
import Html exposing (div, text, input)
import Html.Events exposing (onInput)
import Debug exposing (log)


-- app

type alias State = {}

init : State
init = {}

update action state = state



view state = div [][text "hello"]

m = Browser.sandbox {
        view = view,
        update = update,
        init = init
    }
