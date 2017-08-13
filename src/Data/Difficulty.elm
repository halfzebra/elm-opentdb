module Data.Difficulty exposing (Difficulty(..), dict, toString, byName)

import Dict exposing (Dict)
import Util exposing ((=>))


type Difficulty
    = Any
    | Easy
    | Medium
    | Hard


dict : Dict String Difficulty
dict =
    Dict.fromList
        [ "Any" => Any
        , "Easy" => Easy
        , "Medium" => Medium
        , "Hard" => Hard
        ]


byName : String -> Difficulty
byName name =
    dict
        |> Dict.get name
        |> Maybe.withDefault Any


toString : Difficulty -> String
toString tag =
    dict
        |> Dict.filter (\key value -> value == tag)
        |> Dict.toList
        |> List.head
        |> Maybe.map Tuple.first
        |> Maybe.withDefault "Any"
