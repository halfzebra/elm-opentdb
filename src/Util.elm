module Util exposing ((=>), onChange, replaceHtmlEntities, toBool)

import Html exposing (Attribute)
import Html.Events exposing (on, targetValue)
import Json.Decode


(=>) : a -> b -> ( a, b )
(=>) =
    (,)


onChange : (String -> msg) -> Attribute msg
onChange tagger =
    on "change" (Json.Decode.map tagger targetValue)


replace : String -> String -> String -> String
replace needle replaceWith haystack =
    String.join replaceWith (String.split needle haystack)


htmlEntities : List ( String, String )
htmlEntities =
    [ ( "&#039;", "'" )
    , ( "&rsquo;", "'" )
    , ( "&quot;", "\"" )
    ]


replaceHtmlEntities : String -> String
replaceHtmlEntities str =
    List.foldl (\( needle, replaceWith ) -> replace needle replaceWith) str htmlEntities


toBool : String -> Bool
toBool str =
    if str == "True" then
        True
    else
        False
