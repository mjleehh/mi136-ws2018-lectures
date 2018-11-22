module CustomTypes exposing (m)

import Browser
import Html exposing (div, text)

type Ls a = LCON a (Ls a) | LEND



forEach : (a -> b) -> Ls a -> Ls b
forEach f l = case l of
    LCON first rest -> LCON (f first) (forEach f rest)
    LEND -> LEND

toList : Ls a -> List a
toList l = case l of
    LCON first rest -> first :: (toList rest)
    LEND -> []

type CanBe a = SOME a | EMPTY

type Tup3 a b c = T3_VALUES a b c

type alias MyTup3 = Tup3 Int String Float


type Rec2 a b = R2_VALUES a b

getX : (Rec2 x y) -> x
getX r = case r of
    R2_VALUES value _ -> value

getY : (Rec2 x y) -> y
getY r = case r of
    R2_VALUES _ value -> value

-- type alias MyRec2 = Rec2 Int String

-- init

intList : Ls Int
intList = LCON 1 <| LCON 2 <| LCON 3 LEND

tup3 : MyTup3
tup3 = T3_VALUES 12 "abc" 17.3

rec2 : Rec2 Int String
rec2 = R2_VALUES 12 "foo"

init = {
        l = intList,
        t = tup3,
        r = rec2
    }


divText txt = div [][text txt]

intFieldToDivText record field = divText <| String.fromInt <| field record

view state =
    let
        t = forEach (\elem ->  String.fromInt elem |> divText) state.l |> toList
        l = case state.t of
                T3_VALUES fst snd thrd -> List.map divText [
                        String.fromInt fst,
                        snd,
                        String.fromFloat thrd
                    ]
        nativeRecord = intFieldToDivText {i = 23, f = 4.23} .i
        r = List.map divText [
            String.fromInt <| getX state.r, getY state.r]
    in
        div [][
            div [] t,
            div [] l,
            nativeRecord,
            div [] r
        ]

-- rest

update action state = state

m = Browser.sandbox {
        view = view,
        update = update,
        init = init
    }