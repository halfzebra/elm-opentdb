module Util exposing ((=>), onChange, decodeHtmlEntities, appendIf)

import Html exposing (Attribute)
import Html.Events exposing (on, targetValue)
import Json.Decode
import Http


(=>) : a -> b -> ( a, b )
(=>) =
    (,)


onChange : (String -> msg) -> Attribute msg
onChange tagger =
    on "change" (Json.Decode.map tagger targetValue)


decodeHtmlEntities : String -> String
decodeHtmlEntities str =
    str
        |> Http.decodeUri
        |> Maybe.withDefault ""


appendIf : Bool -> a -> List a -> List a
appendIf flag value list =
    if flag == True then
        list ++ [ value ]
    else
        list
