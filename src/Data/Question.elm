module Data.Question exposing (Question, decoder)

import Json.Decode exposing (Decoder, map, map4, field, list, string)
import Util exposing (replaceHtmlEntities, toBool)


type alias Question =
    { userAnswer : Maybe String
    , category : String
    , question : String
    , correct : String
    , incorrect : List String
    }


decoder : Decoder Question
decoder =
    map4 (Question Nothing)
        (field "category" string)
        (field "question" (map replaceHtmlEntities string))
        (field "correct_answer" string)
        (field "incorrect_answers" (list string))
