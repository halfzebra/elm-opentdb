module Data.Difficulty exposing (Difficulty(..), list, toString, byName)

import Dict exposing (Dict)
import Util exposing ((=>))


type Difficulty
    = Any
    | Easy
    | Medium
    | Hard


list : Dict String Difficulty
list =
    Dict.fromList
        [ "Any" => Any
        , "Easy" => Easy
        , "Medium" => Medium
        , "Hard" => Hard
        ]


byName : String -> Difficulty
byName name =
    list
        |> Dict.get name
        |> Maybe.withDefault Any


toString : Difficulty -> String
toString tag =
    list
        |> Dict.filter (\key value -> value == tag)
        |> Dict.toList
        |> List.head
        |> Maybe.map (\( a, _ ) -> a)
        |> Maybe.withDefault "Any"
