module Lecture exposing (m)

import Browser
import Html exposing (div, text, input)
import Html.Events exposing (onInput)
import Debug exposing (log)

a : Float
a = 12

b : String
b = "elm"

type Action = UPDATE_THIS | UPDATE_THAT String


c : List Int
c = [12, 23]

d : {a: Int, b: String}
d = {
        a = 12,
        b = "foo"
    }

type alias T a b = {
        f1: a,
        f2: b
    }

t : T Int Float
t =

e : (Int, String)
e = (12, "foo")


f : number -> number -> number
f a b c = a + b

g a b = a * b

h a = a * a * a

a1 = f (g 12 (h 12)) g(12, 12) (g 12 (h 12))

type T1 = FOO | BAR (Int, Float, Int, Float)| BLA List String


-- FOO : A

-- Ls a = type ...

-- app

type alias State = {}

init : State
init = {}

update : Action -> State -> State
update action state = state



view state = div [][text "hello"]

m = Browser.sandbox {
        view = view,
        update = update,
        init = init
    }
