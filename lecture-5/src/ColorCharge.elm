module ColorCharge exposing (m)

import Browser
import Html exposing (div, text, input)
import Html.Events exposing (onInput)
import Regex
import Debug exposing (log)


type Color = INVALID | N | R | G | B

colorToString : Color -> String
colorToString color = case color of
    INVALID -> "NaC"
    N -> "N"
    R -> "R"
    G -> "G"
    B -> "B"

stringToColor : String -> Color
stringToColor str = case str of
    "N" -> N
    "R" -> R
    "G" -> G
    "B" -> B
    _ -> INVALID

add : Color -> Color -> Color
add c1 c2 = addTuple (c1, c2)

addTuple arg = case arg of
    (INVALID, x) -> INVALID
    (N, b) -> b
    (a, N) -> a
    (R, x) -> case x of
        R -> N
        G -> B
        B -> G
        _ -> INVALID
    (G, x) -> case x of
        G -> N
        B -> R
        R -> B
        _ -> INVALID
    (B, x) -> case x of
        B -> N
        R -> G
        G -> R
        _ -> INVALID

addList : List Color -> Color
addList colors = List.foldl add N colors

regexInput = Maybe.withDefault Regex.never <| Regex.fromString "\\s*[\\+\\s]+\\s*"

type Action = UPDATE_INPUT String

type alias State = {
        input: Maybe (List Color)
    }

init : State
init = {
        input = Nothing
    }

update : Action -> State -> State
update action state = case action of
        UPDATE_INPUT str ->
            let
                colors = Regex.split regexInput str
                    |> List.filter (\elem -> elem /= "")
                    |> List.map stringToColor
                b = log "list" colors
                isInvalid = log "valid" <| List.any (\item -> item == INVALID) colors
            in
                if isInvalid then
                    {state | input = Nothing}
                else
                    {state | input = Just colors}



view state =
    let
        output = case state.input of
            Just colors ->
                div [][text <| colorToString <| addList colors]
            Nothing -> div [][text "invalid input"]
    in
        div [][
            input [onInput UPDATE_INPUT][],
            output
        ]

m = Browser.sandbox {
        view = view,
        update = update,
        init = init
    }