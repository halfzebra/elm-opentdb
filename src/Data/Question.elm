module Data.Question exposing (Question, decoder)

import Json.Decode exposing (Decoder, map, map4, field, list, string)
import Util exposing (replaceHtmlEntities)


type alias Question =
    { userAnswer : Maybe String
    , category : String
    , question : String
    , correct : String
    , incorrect : List String
    }


stringWithHtmlEntities : Decoder String
stringWithHtmlEntities =
    map replaceHtmlEntities string


decoder : Decoder Question
decoder =
    map4 (Question Nothing)
        (field "category" string)
        (field "question" stringWithHtmlEntities)
        (field "correct_answer" string)
        (field "incorrect_answers" (list stringWithHtmlEntities))
