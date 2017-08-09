module Request.TriviaQuestions exposing (..)

import Json.Decode exposing (Decoder, field, map2, list, int)
import Data.Question exposing (Question)
import Data.Difficulty exposing (Difficulty(..))
import Http exposing (Error)
import Util exposing ((=>), appendIf)
import Request.Helpers exposing (queryString)


type alias TriviaResult =
    { responseCode : Int
    , questions : List Question
    }


decoder : Decoder TriviaResult
decoder =
    map2 TriviaResult
        (field "response_code"
            (int
                |> Json.Decode.andThen
                    (\val ->
                        if val /= 0 then
                            Json.Decode.fail "Failed to retrieve Trivia Questions"
                        else
                            Json.Decode.succeed val
                    )
            )
        )
        (field "results" (list Data.Question.decoder))


apiUrl : String -> String
apiUrl str =
    "https://opentdb.com/api.php" ++ str


triviaUrl : Int -> Difficulty -> String
triviaUrl amount difficulty =
    let
        difficultyValue : String
        difficultyValue =
            String.toLower (Data.Difficulty.toString difficulty)
    in
        [ "amount" => (toString amount) ]
            |> appendIf (difficulty /= Any) ("difficulty" => difficultyValue)
            |> queryString
            |> apiUrl


get : Int -> Difficulty -> (Result Error TriviaResult -> msg) -> Cmd msg
get amount difficulty msg =
    Http.get (triviaUrl amount difficulty) decoder
        |> Http.send msg
