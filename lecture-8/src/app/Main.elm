module App exposing (main)

import Browser
import Html exposing (div, text)
import Http
import Debug

import Json.Decode as Decode

type Action = FETCHED (Result Http.Error State)

fetch = Http.get {
        url = "/api/lcd",
        expect = Http.expectJson FETCHED decodeFetch
    }

type alias State = {
        on: Bool
        ,firstLine: String
        ,secondLine: String
    }

decodeFetch = Decode.map3 State
        (Decode.field "on" Decode.bool)
        (Decode.field "firstLine" Decode.string)
        (Decode.field "secondLine" Decode.string)


init: () -> (State, Cmd Action)
init flags = ({
        on = True
        ,firstLine = ""
        ,secondLine = ""
    }, fetch)

update action state =
    let
        a = Debug.log "" action
    in
        case action of
            FETCHED (Ok newState) -> (newState, Cmd.none)
            FETCHED _ -> (state, Cmd.none)

view state = div [][
        text "hello elm"
    ]

subscriptions state = Sub.none

main = Browser.element {
        init = init
        ,update = update
        ,view = view
        ,subscriptions = subscriptions
    }