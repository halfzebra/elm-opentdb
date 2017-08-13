module View.Difficulty exposing (option)

import Html exposing (Html, text)
import Html.Attributes exposing (selected, value)
import Data.Difficulty exposing (Difficulty)


option : Difficulty -> String -> Html msg
option current key =
    Html.option
        [ selected ((Data.Difficulty.toString current) == key)
        , value key
        ]
        [ text key ]
