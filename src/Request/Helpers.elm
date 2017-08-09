module Request.Helpers exposing (queryString)

import Http exposing (encodeUri)


queryString : List ( String, String ) -> String
queryString list =
    list
        |> List.map (\( a, b ) -> a ++ "=" ++ b)
        |> String.join "&"
