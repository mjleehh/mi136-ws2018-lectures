module N exposing (m)

import Browser
import Html exposing (div, text, input)
import Html.Events exposing (onInput)
import Debug exposing (log)


-- natural numbers

type Sign = PLUS | MINUS

type Abs = PLUS_ONE Abs | ZERO

type Number = NUMBER Sign Abs

zero = NUMBER PLUS ZERO

signToInt sign = case sign of
    PLUS -> 1
    MINUS -> -1

numberToInt: Number -> Int
numberToInt number = case number of
    NUMBER sign abs ->
        let
            addUp i n = case n of
                PLUS_ONE rest -> addUp (i + 1) rest
                ZERO -> i
        in
            (addUp 0 abs) * (signToInt sign)

intToNumber: Int -> Number
intToNumber int =
    let
        create i = if i > 0
            then PLUS_ONE <| create (i - 1)
            else ZERO
        absPart =  create (abs int)
        signPart = if int < 0
            then MINUS
            else PLUS
    in
        NUMBER signPart absPart

add : Number -> Number -> Number
add lhs rhs = case (lhs, rhs) of
    (NUMBER PLUS abs1, NUMBER PLUS abs2) -> NUMBER PLUS (addAbs abs1 abs2)
    (NUMBER MINUS abs1, NUMBER MINUS abs2) -> NUMBER MINUS (addAbs abs1 abs2)
    (NUMBER MINUS abs1, NUMBER PLUS abs2) -> absMinusAbs abs2 abs1
    (NUMBER PLUS abs1, NUMBER MINUS abs2) -> absMinusAbs abs1 abs2

addAbs : Abs -> Abs -> Abs
addAbs lhs rhs = case lhs of
    PLUS_ONE rest -> PLUS_ONE (addAbs rest rhs)
    ZERO -> rhs

absMinusAbs : Abs -> Abs -> Number
absMinusAbs abs1 abs2 = case (abs1, abs2) of
    (ZERO, ZERO) -> zero
    (PLUS_ONE lrest, PLUS_ONE rrest) -> absMinusAbs lrest rrest
    (PLUS_ONE lrest, ZERO) -> NUMBER PLUS (PLUS_ONE lrest)
    (ZERO, PLUS_ONE rrest) -> NUMBER MINUS (PLUS_ONE rrest)


-- app

type Action = UPDATE_INPUT String

type alias State = {
        input: Maybe (List Number)
    }

init : State
init = {
        input = Nothing
    }

update : Action -> State -> State
update action state = case action of
        UPDATE_INPUT str ->
            let
                maybeInts = String.words str |> List.map String.toInt
                isInvalid = List.any (\elem -> elem == Nothing) maybeInts
                maybeIntToNumber maybeInt = Maybe.withDefault 0 maybeInt |> intToNumber
                numbers = if isInvalid then
                        Nothing
                    else
                        Just (List.map maybeIntToNumber maybeInts)
            in
                {state | input = numbers}



view state =
    let
        output = case state.input of
            Just numbers ->
                let
                    sum = List.foldl add zero numbers
                    number = String.fromInt <| numberToInt sum
                in
                    div [][text number]

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
