module Views exposing (..)

import Html
import Html.Attributes exposing (class)
import Test exposing (Test, test)
import Test.Html.Query
import Test.Html.Selector exposing (text, tag)
import View.Question
import Data.Question exposing (Question)


suite : Test
suite =
    test "Question has the button with correct answer" <|
        \_ ->
            let
                question =
                    Question
                        Nothing
                        "Why did the chicken cross the road?"
                        "To get to the other side"
                        []
            in
                View.Question.view question (\_ -> never)
                    |> Test.Html.Query.fromHtml
                    |> Test.Html.Query.find [ tag "button" ]
                    |> Test.Html.Query.has [ text "To get to the other side" ]
