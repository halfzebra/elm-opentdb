module Request.TriviaQuestions exposing (TriviaResult, get, decoder, codeToError)

import Json.Decode exposing (Decoder, field, map2, list, int)
import Data.Question exposing (Question)
import Data.Difficulty exposing (Difficulty, isAny)
import Http exposing (Error)
import Util exposing ((=>), appendIf)
import Request.Helpers exposing (queryString)
import Dict exposing (Dict)


type alias TriviaResult =
    { code : Int
    , questions : List Question
    }


apiUrl : String -> String
apiUrl str =
    "https://opentdb.com/api.php" ++ str


decoder : Decoder TriviaResult
decoder =
    map2 TriviaResult
        (field "response_code" int)
        (field "results" (list Data.Question.decoder))


triviaRequestUrl : Int -> Difficulty -> String
triviaRequestUrl amount difficulty =
    let
        difficultyValue : String
        difficultyValue =
            String.toLower (Data.Difficulty.toString difficulty)

        shouldAppend : Bool
        shouldAppend =
            not (isAny difficulty)

        queryParameterToAppend : ( String, String )
        queryParameterToAppend =
            ("difficulty" => difficultyValue)
    in
        [ "amount" => (toString amount)
        , "encode" => "url3986"
        ]
            |> appendIf shouldAppend queryParameterToAppend
            |> queryString
            |> apiUrl


get : Int -> Difficulty -> (Result Error TriviaResult -> msg) -> Cmd msg
get amount difficulty msg =
    Http.get (triviaRequestUrl amount difficulty) decoder
        |> Http.send msg


defaultError : String
defaultError =
    "No Results Could not return results. The API doesn't have enough questions for your query. (Ex. Asking for 50 Questions in a Category that only has 20.)"


errors : Dict Int String
errors =
    Dict.fromList
        [ 1 => defaultError
        , 2 => "Invalid Parameter Contains an invalid parameter. Arguements passed in aren't valid. (Ex. Amount = Five)"
        , 3 => "Token Not Found Session Token does not exist."
        , 4 => "Token Empty Session Token has returned all possible questions for the specified query. Resetting the Token is necessary."
        ]


codeToError : Int -> String
codeToError key =
    Dict.get key errors
        |> Maybe.withDefault defaultError
